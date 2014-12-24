module VSSC
  class Party < BallotSelection
    include VSSC::ClassAttributes
    
    define_attribute("abbreviation")
    define_attribute("localPartyCode")
    define_attribute("name")
    define_attribute("nationalPartyCode")
    define_attribute("statePartyCode")
    
  end
end