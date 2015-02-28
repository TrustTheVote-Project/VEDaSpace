module Hart
  class Mapper
    BASE = "doc/hart/G12"
    DEFAULTS={:path=>BASE, :format=>:tdf, :headers=>false}
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
    
    # DMap::File.define_relation('POLLING_PLACE_AND_PRECINCT.txt', DEFAULTS) do |df|
    #   df.polling_place_precinct({:polling_place_id=>[:polling_place, :id]},
    #     :polling_place_type, {:precinct_split_id=>[:precinct_split, :id]})
    # end
        
    # puts DMap::Report.new.text(:district)
    
    #full stack
    #puts DMap::Report.new(:precinct).text
    
    # single associations
    # puts DMap::Report.new(:precinct=>:district).text
    # puts DMap::Report.new(:district=>:precinct).text
    
    
    
    
  end
end