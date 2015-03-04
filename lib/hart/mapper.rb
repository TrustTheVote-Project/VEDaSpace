require './lib/dmap.rb'

module Hart
  class Mapper
    
    BASE = "doc/hart/G12"
    DEFAULTS={:path=>BASE, :format=>:tdf, :headers=>false}

    def self.map
    
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

      # DMap::File.define_relation("CONTEST_AND_PRECINCT.txt", DEFAULTS) do |df|
      #   df.contest_precinct_split({:contest_id=>[:contest, :id]}, {:precinct_split_id=>[:precinct_split, :id]})
      # end

      DMap::File.define_relation("DISTRICT_AND_CONTEST.txt", DEFAULTS) do |df|
        df.district_contest({:district_id=>[:district, :id]}, {:contest_id=>[:contest, :id]})
      end

      # DMap::File.define_relation('POLLING_PLACE_AND_PRECINCT.txt', DEFAULTS) do |df|
      #   df.polling_place_precinct({:polling_place_id=>[:polling_place, :id]},
      #     :polling_place_type, {:precinct_split_id=>[:precinct_split, :id]})
      # end

    end
        
    #full stack
    # puts DMap::Report.new(:precinct).text
    
    
    
    
  end
end