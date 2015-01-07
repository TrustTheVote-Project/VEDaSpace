module VSSC
  class Election
    include VSSC::ClassAttributes
    define_element("BallotStyleCollection", type: BallotStyleCollection)
    define_element("CandidateCollection", type: CandidateCollection)
    define_element("ContestCollection", type: ContestCollection)
    define_element("ElectionGPScope")
    
    define_attribute("object_id", required: true)
    define_attribute("name", required: true)
    define_attribute("type", required: true, type: ElectionType)
    define_attribute("date", required: true, type: "xsd:date")
    define_attribute("URL")
    
    define_attribute("absenteeCountStatus", type: BallotCountStatus)
    define_attribute("earlyCountStatus", type: BallotCountStatus)
    define_attribute("electionDayCountStatus", type: BallotCountStatus)
    define_attribute("provisionalCountStatus", type: BallotCountStatus)
    define_attribute("writeInCountStatus", type: BallotCountStatus)
    
    
  end
end