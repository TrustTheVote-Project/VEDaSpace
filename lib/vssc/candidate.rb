module VSSC
  class Candidate
    include VSSC::ClassAttributes
    define_element("Party")
    define_element("Person")
    define_element("Office", multiple: true)
    
    define_attribute("object_id", required: true)

    define_attribute("ballotName", required: true)

    define_attribute("candidateID")

    define_attribute("fileDate", type: "xsd:dateTime")
    
    define_attribute("isIncumbent", type: "xsd:boolean")
    
    define_attribute("isTopTicket", type: "xsd:boolean")
    
    define_attribute("sequenceOrder", type: Fixnum)
    
    define_attribute("status", type: CandidateStatus)

  end
end