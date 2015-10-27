module VSSC
  class ReportingUnit < GPUnit
    include VSSC::ClassAttributes
    
    define_element("Authority", multiple: true)
    define_element("ReportingUnitContact", multiple: true, type: Contact)
    
    define_attribute("reportingUnitType", type: ReportingUnitType, required: true)
    define_attribute("hasReported", type: "xsd:boolean")
    define_attribute("registeredVoters", type: Fixnum)
    define_attribute("reportedPrecincts", type: Fixnum)
    define_attribute("totalParticipatingVoters", type: Fixnum)
    define_attribute("totalPrecincts", type: Fixnum)
    
  end
end