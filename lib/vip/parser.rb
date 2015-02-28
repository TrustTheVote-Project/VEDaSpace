module VIP
  
  # VIP elements to VSSC concepts   # schemaVersion (attribute)
  # source - publisher info (N/A)
  # election - Election
  # state - GPUnit (ReportingUnit) that is a state, may be needed for cross-ref, has Authority, Contact
  # locality - GPUnit (ReportingUnit), has Authority, Contact
  # precint/precint_split - GPUnits that are Districts - no Authority (no election_administration_id). But they do have "Contact" (e.g. polling_location, eary_vote_site)
  # contest - Contest (specifically for candidates?)
  # candidate - Candidate
  # referendum - BallotMeasure
  # ballot_response - an option for a response to a candidate or measure or custom a BallotSelection
  # election_administration - Used as a map from electoral_districts to an Authority (contact person)
  # election_official - Authority for a ReportingUnit
  # polling_location - Contact (address) for a ReportingUnit
  # early_vote_site - Contact (address) for a ReportingUnit
  # electoral_distric - district definition for 1 particular contest. Used to group GPUnits. Is it a District or ReportingUnit (no contact info, but needs "Type" matching)
  # ballot - references referrendums and Contests
  # ballot_style - ordered set of Contest (measures or candidates)
  # precinct_split_electoral_district - matches IDs of precint-split, precint, electoral district (n/a?)
  # precinct_split_ballot_style - matches ids of precing-split, precing and ballot_style
  # party - Party
  # custom_ballot - ballot with custom Contests
  # street segment - piece of address for state/precing/precinct split
  # contest_result - TotalCounts
  # ballot_line_result - VoteCounts for a particular ballot selection 
  
  class Parser < VSSC::Parser
    def self.parse(file_contents_or_path)
      report = VSSC::ElectionReport.new
      recurse_nodes(noko_doc(file_contents_or_path).root, report)
      return report
    end
    
    def self.recurse_nodes(node, report)
      node.children.each do |c|
        handle_vip_node(c, report)
      end
    end
    
    def self.handle_vip_node(node, report)
      case node.name
      when "source"
        report.issuer = node.css("> name").text
        begin
          report.date = DateTime.iso8601(node.css("> date").text)
        rescue 
        end
        
      when "state"
        report.state_code = node.attributes["id"]
        report.state_abbreviation = node.css("> abbreviation").text
        
        state = VSSC::ReportingUnit.new
        state.object_id = "_#{node.attributes["id"]}"
        state.name = node.css("> name").text
        state.reporting_unit_type = VSSC::ReportingUnitType.state
        
        node.css("> locality").each do |l_node|
          locality = VSSC::ReportingUnit.new
          locality.object_id = "_#{l_node.attributes["id"]}"
          locality.name = l_node.css("> name").text 
          locality.reporting_unit_type = VSSC::ReportingUnitType.find(l_node.css("> type").text)
          state.gp_sub_unit << locality
          # TODO: Get Authority from election_administration_id - eo_id / ovc_id
          # Get Contact from things like polling places
        end
        
        report.gp_unit_collection ||= VSSC::GPUnitCollection.new
        report.gp_unit_collection.gp_unit << state
      when "election"
        e = VSSC::Election.new
        e.object_id = "_#{node.attributes["id"]}"
        begin
          e.date = DateTime.iso8601(node.css("> date").text)
        rescue
        end
        e.type = VSSC::ElectionType.find(node.css("> election_type").text)
        e.name = node.css("> name").text 
        e.name = e.object_id if e.name.blank?
        report.election << e
      when "electoral_district"
        d = VSSC::District.new
        # [id] name, type, number, description
        d.object_id = "_#{node.attributes["_id"]}"
        d.name = node.css("> name").text
        #TODO: Is it a district or reporting unit? Mapping types to the Enum set of types
        d.district_type = VSSC::DistrictType.find(node.css("> type").text)
        d.local_geo_code = node.css("> number").text
        
        puts d.inspect
        
        report.gp_unit_collection  ||= VSSC::GPUnitCollection.new
        report.gp_unit_collection.gp_unit << d
      else
        raise "Not implemented #{node.inspect}"
      end
      
      
    end
    
  end
end