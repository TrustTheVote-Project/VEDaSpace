require './lib/dmap.rb'
require './lib/vssc.rb'
require 'nokogiri'

module Hart
  class Mapper
    
    BASE = "doc/hart/G12"
    DEFAULTS={:path=>BASE, :format=>:tdf, :headers=>false}
    
    DMap::File.define("ELECTION.txt", DEFAULTS) do |df|
      df.election_report :name, :locality, :election_type, :date, :state_abbreviation, 
                         :unknown?, :unknown?, :unknown?, :unknown?, :unknown?, :unknown?, :format
    end

    DMap::File.define("PARTY.txt", DEFAULTS) do |df|
      df.party :abbreviation, :name, :id
    end
    
    
    DMap::File.define("CONTEST.txt", DEFAULTS) do |df|
      df.contest :id, :order, :office, :contest_type, :instruction_text, :ballot_measure_title,
                 :unknown?, :unknown?, :number_elected
    end

    DMap::File.define("CANDIDATE.txt", DEFAULTS) do |df|
      df.candidate({:contest_id=>[:contest, :id]}, :id, :order, :unknown?, :name, :unknown?, {:party_id=>[:party, :id]})
    end
    
    
    DMap::File.define("PRECINCT.txt", DEFAULTS) do |df|
        df.precinct_split :id, :order, {:precinct_id=>[:precinct, :id]}, :precinct_split_type, :unknown?
        df.precinct(:NA, :NA, :id, :NA, :NA)
    end
    DMap::File.define("DISTRICT.txt", DEFAULTS) do |df|
      df.district :id, :name
    end
    
    DMap::File.define_relation("PRECINCT_AND_DISTRICT.txt", DEFAULTS) do |df|
      df.district_precinct_split({:district_id=>[:district, :id]}, {:precinct_split_id=>[:precinct_split, :id]})
    end
    
    DMap::File.define("POLLING_PLACE.txt", DEFAULTS) do |df|
      df.polling_place :id, :name, :short_name
    end
    
    DMap::File.define("CONTEST.txt", DEFAULTS) do |df|
      df.hart_contest :id, :order, :name, :type, :instructions, :description
    end

    DMap::File.define_relation("CONTEST_AND_PRECINCT.txt", DEFAULTS) do |df|
      df.contest_precinct_split({:contest_id=>[:contest, :id]}, {:precinct_split_id=>[:precinct_split, :id]})
    end
    
    # DMap::File.define_relation('POLLING_PLACE_AND_PRECINCT.txt', DEFAULTS) do |df|
    #   df.polling_place_precinct({:polling_place_id=>[:polling_place, :id]},
    #     :polling_place_type, {:precinct_split_id=>[:precinct_split, :id]})
    # end
        
    #full stack
    # puts DMap::Report.new(:precinct).text
    
    er = DMap::ModelRegister.classes[:election_report].all.values.first
    
    # build the election report
    report = VSSC::ElectionReport.new
    election = VSSC::Election.new
    report.election << election
    
    report.object_id= "election-report-#{er.name}"
    election.object_id="election-#{er.name}"
    
    report.issuer = er.locality
    report.sequence = 0
    report.sequence_end = 0
    report.vendor_application_id = "OSET-VSSC-RUBY-HART-MAPPER"
    report.format = er.format == 'Precinct' ? VSSC::ReportFormat.precinct_level : VSSC::ReportFormat.summary_contest
    report.status = VSSC::ReportStatus.test    
    
    report.date = DateTime.iso8601(Date.parse(er.date).iso8601)
    report.state_abbreviation = er.state_abbreviation
    report.gp_unit_collection = VSSC::GPUnitCollection.new
    
    # put in all the districts in with the related precinct-splits
    # Make a hash of districts based on set of sub-gpus
    district_from_gpus = {}
    DMap::ModelRegister.classes[:district].all.values.each do |d|
      district = VSSC::District.new
      district.object_id = "district-#{d.attributes[:id]}"
      district.name = d.attributes[:name]
      
      d.relations(:district_precinct_split).each do |d_p_split|
        district.gp_sub_unit_ref << "precinct-split-#{d_p_split.attributes[:precinct_split_id]}"
      end
      
      ps_ids = d.relations(:district_precinct_split).collect{|ps| ps.precinct_split_id.to_i}.sort
      p_ids = ps_ids.collect {|ps_id| 
        ps = DMap::ModelRegister.classes[:precinct_split].find(ps_id.to_s)
        %w(Limited Full).include?(ps.precinct_split_type) ? nil : ps.precinct_id
      }.compact.uniq.sort
      if district_from_gpus[p_ids]
        puts [district_from_gpus[p_ids], "district-#{d.id}"].join(" ")
      end
      district_from_gpus[p_ids] = "district-#{d.id}"
      
      report.gp_unit_collection.gp_unit << district
      
    end
    
    # put all the precincts in with the related precinct-splits
    DMap::ModelRegister.classes[:precinct].all.values.each do |p|
      precinct = VSSC::GPUnit.new
      precinct.object_id = "precinct-#{p.id}"
      
      p.relations(:precinct_split).each do |p_split|
        precinct.gp_sub_unit_ref << "precinct-split-#{p_split.id}"
      end
      
      report.gp_unit_collection.gp_unit << precinct
      
    end
    
    report.party_collection = VSSC::PartyCollection.new
    DMap::ModelRegister.classes[:party].all.values.each do |p|
      party = VSSC::Party.new
      party.abbreviation = p.abbreviation
      party.name = p.name
      party.object_id = "party-#{p.id}"
      
      report.party_collection.party << party
    end
    
    election.candidate_collection = VSSC::CandidateCollection.new
    DMap::ModelRegister.classes[:candidate].all.values.each do |c|
      candidate = VSSC::Candidate.new
      candidate.object_id ="candidate-#{c.id}"
      candidate.party = "party-#{c.party_id}"
      candidate.ballot_name = c.name
      candidate.sequence_order = c.order
      election.candidate_collection.candidate << candidate
    end
    
    
    election.contest_collection = VSSC::ContestCollection.new
    report.office_collection = VSSC::OfficeCollection.new
    DMap::ModelRegister.classes[:contest].all.values.each do |c|
      contest = nil
      if c.contest_type.downcase == "c"
        contest = VSSC::CandidateChoice.new
        contest.office = "office-#{c.id}"
        
        office = VSSC::Office.new
        office.object_id = "office-#{c.id}"
        office.name = c.office
        report.office_collection.office << office
        
        
        contest.number_elected = c.number_elected
        # For each candidate
        c.relations(:candidate).each do |candidate|
          candidate_selection= VSSC::CandidateSelection.new
          candidate_selection.object_id ="candidate-selection-#{candidate.id}"
          candidate_selection.candidate << "candidate-#{candidate.id}"
          contest.ballot_selection << candidate_selection
        end
      elsif c.contest_type.downcase == "p"
        contest = VSSC::BallotMeasure.new
        contest.full_text = c.ballot_measure_title
        c.relations(:candidate).each do |candidate|
          candidate_selection= VSSC::BallotMeasureSelection.new
          candidate_selection.object_id ="ballot-measure-selection-#{candidate.id}"
          candidate_selection.selection = candidate.name
          contest.ballot_selection << candidate_selection
        end
      elsif c.contest_type.downcase == "s"
        contest = VSSC::StraightParty.new
        c.relations(:candidate).each do |candidate|
          candidate_selection = VSSC::Party.new
          candidate_selection.object_id = "party-#{candidate.id}"
          contest.ballot_selection << candidate_selection
        end
        # Straight Party
        
      else
        # Don't record generic ballot text
        next
      end
      
      # For whatever the contest, look at all the precinct-splits in the contest/precinct-split
      # and detect an exatly-matching district
      ps_ids = c.relations(:contest_precinct_split).collect{|ps| ps.precinct_split_id.to_i}.sort
      p_ids = ps_ids.collect {|ps_id| 
        ps = DMap::ModelRegister.classes[:precinct_split].find(ps_id.to_s)
        %w(Limited Full).include?(ps.precinct_split_type) ? nil : ps.precinct_id
      }.compact.uniq.sort
      
      contest.contest_gp_scope = district_from_gpus[p_ids]
      if contest.contest_gp_scope.blank?
        puts c.office.to_s + ' ' + p_ids.to_s
      end
      
      contest.object_id = "contest-#{c.id}"
      contest.name = c.office
      contest.sequence_order = c.order
      #:order, :id, :office, :contest_type, :instruction_text, :ballot_measure_title
      
      
      election.contest_collection.contest << contest
    end
    
    puts report.valid?
    puts report.errors.messages.collect{|k,v|"#{k}: #{v}"}.join("\n")
    puts report.to_xml_node.doc.to_s
    
    
    # single associations
    # puts DMap::Report.new(:precinct=>:district).text
    # puts DMap::Report.new(:district=>:precinct).text
    
    
    
    
  end
end