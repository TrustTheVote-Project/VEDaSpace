require './lib/hart/mapper.rb'
require './lib/vssc.rb'
require 'nokogiri'

module Hart
  class OcdIdGen
    def self.gen
      Hart::Mapper.map
      
      rows = []
      
      # DMap::ModelRegister.classes[:district].all.values.each do |d|
      #   row = [
      #     "District",
      #     d.attributes[:name],
      #     d.attributes[:id],
      #     "ocd", # "ocd-division/country:us/state:tx/????"
      #     "??? District"
      #   ]
      #
      #   rows << row
      # end
      
      DMap::ModelRegister.classes[:precinct].all.values.each do |p|
        row = [
          "Precinct",
          p.id,
          "Precinct #{p.id}",
          "Precinct",
          "",
          "",
          "Precint",
          "",
          "ocd-division/country:us/state:txt/county:travis/precinct:#{p.id}"
        ]
        rows << row
      
      end
      
      DMap::ModelRegister.classes[:precinct_split].all.values.each do |ps|
        row = [
          "PrecinctSplit",
          ps.id,
          "PrecinctSplit #{ps.id}",
          "PrecinctSplit",
          "",
          "",
          "PrecinctSplit",
          "",
          "ocd-division/country:us/state:txt/county:travis/precinct_split:#{ps.id}"
          
        ]
        relations = ["Precinct:#{ps.precinct_id}"]
        
        ps.relations(:district_precinct_split).each do |d_p_split|
          relations << "District:#{d_p_split.district_id}"
        end
        row << relations.join(",")
        
        rows << row
      end
      
      CSV.open("travis_hart_precinct_mappings.csv", "w") do |csv|
        rows.each do |r|
          csv << r
        end
      end
      
    end
  end
end

Hart::OcdIdGen.gen