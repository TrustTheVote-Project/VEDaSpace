require './lib/hart/mapper.rb'
require './lib/vssc.rb'
require 'nokogiri'

module Hart
  class Parser
    def self.parse(include_results=true)
      
      Hart::Mapper.map
      
      
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
      
      # districts also need extra data to be complete
      district_meta = {}
      district_rows = CSV.read('./doc/hart/G12/MODIFIED_DISTRICT.csv', :headers=>true)
      district_rows.each do |row|
        district_meta[row['ID']] = row
      end
      
      
      DMap::ModelRegister.classes[:district].all.values.each do |d|
        district = VSSC::District.new
        district.object_id = "district-#{d.attributes[:id]}"
        district.name = d.attributes[:name]
        district.district_type = case district_meta[d.id]['DISTRICTTYPE'].downcase.to_s
        when "city"
          VSSC::DistrictType.locality
        when "federal ballot"
          VSSC::DistrictType.statewide
        else
          VSSC::DistrictType.local
        end
        
        ## CUSTOM STUFF
        if district.name =~ /Congressional/i
          district.district_type = VSSC::DistrictType.congressional
        elsif district.name =~ /Senate/i
          district.district_type = VSSC::DistrictType.state_house
        elsif district.name =~ /Legislative/i
          district.district_type = VSSC::DistrictType.state_senate
        end
        
        
        d.relations(:district_precinct_split).each do |d_p_split|
          district.gp_sub_unit_ref << "precinct-split-#{d_p_split.attributes[:precinct_split_id]}"
        end
            
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
    
      # CUSTOM  pullng results from CSV
      results = CSV.read("./doc/hart/20121106results-mod.csv", :headers=>true)
      contest_candidates = {}
      results.each do |row|
        cc = "#{row['Contest_Id']} - #{row['candidate_id']}"
        contest_candidates[cc] ||= []
        contest_candidates[cc] << row
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
          contest_gp_units = {}
          c.relations(:candidate).each_with_index do |candidate, i|
            candidate_selection= VSSC::CandidateSelection.new
            candidate_selection.object_id ="candidate-selection-#{candidate.id}"
            candidate_selection.candidate << "candidate-#{candidate.id}"
            
            cc = "#{c.id} - #{candidate.id}"
            if include_results
              contest_candidates[cc].each do |row|
                vc_a = VSSC::VoteCounts.new
                vc_e = VSSC::VoteCounts.new
                vc = VSSC::VoteCounts.new
                # "Precinct_name":"101" 
                # "Reporting_flag":"1" 
                # "total_ballots":"2061"
                # "total_votes":"1110"
                # "total_under_votes":"757"
                # "total_over_votes":"0"
                # "absentee_ballots":"48"
                # "absentee_votes":"28"
                # "absentee_under_votes":"18"
                # "absentee_over_votes":"0"
                # "early_ballots":"1133"
                # "early_votes":"628"
                # "early_under_votes":"406"
                # "early_over_votes":"0"
                # "election_ballots":"880"
                # "election_votes":"454"
                # "election_under_votes":"333"
                # "election_over_votes":"0"
                vc_e.gp_unit = vc.gp_unit = vc_a.gp_unit = "precinct-split-#{row["Pct_Id"]}"
                vc_a.object_id = "votecount-#{cc}-absentee"
                vc_a.ballot_type = VSSC::BallotType.absentee
                vc_a.count = row["absentee_votes"]
                vc_e.object_id = "votecount-#{cc}-early"
                vc_e.ballot_type = VSSC::BallotType.early
                vc_e.count = row["early_votes"]
                vc.object_id = "votecount-#{cc}-election-day"
                vc.ballot_type = VSSC::BallotType.election_day
                vc.count = row["election_votes"]
                candidate_selection.vote_counts << vc
                candidate_selection.vote_counts << vc_a
                candidate_selection.vote_counts << vc_e
              
                # for the first candidate in the loop put in the totals
                if i == 0
                  total_count = VSSC::TotalCounts.new
                  total_count.gp_unit = "precinct-split-#{row["Pct_Id"]}"
                  total_count.object_id = "total-counts-#{total_count.gp_unit}-#{c.id}"
                  total_count.ballots_cast = row["total_ballots"]
                  total_count.overvotes = row["total_over_votes"]
                  total_count.undervotes = row["total_under_votes"]
                  contest.contest_total_counts_by_gp_unit << total_count
                end
              end
            end
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
        puts c.relations(:district_contest).collect(&:district_id).join(", ")
        district_id = c.relations(:district_contest).last.district_id
        contest.contest_gp_scope = "district-#{district_id}"

        contest.object_id = "contest-#{c.id}"
        contest.name = c.office
        contest.sequence_order = c.order
        #:order, :id, :office, :contest_type, :instruction_text, :ballot_measure_title
      
      
        election.contest_collection.contest << contest
      end
    
      puts report.valid?
      puts report.errors.messages.collect{|k,v|"#{k}: #{v}"}.join("\n")
      
      File.open(report.object_id + "#{include_results ? '-results' : ''}-vssc.xml", "w+") do |f|
        f.write report.to_xml_node.doc.to_s
      end
    
      
      
    end
  end
end

Hart::Parser.parse(true)