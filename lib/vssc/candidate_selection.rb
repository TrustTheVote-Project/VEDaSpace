module VSSC
  class CandidateSelection < BallotSelection
    include VSSC::ClassAttributes
    define_element("Candidate", multiple: true)
    define_element("EndorsementParty", multiple: true)
    
    define_attribute("isWriteIn", type: "xsd:boolean")
  end
end