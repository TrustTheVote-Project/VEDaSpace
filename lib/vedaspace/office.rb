module VSSC
  class Office
    include VSSC::ClassAttributes
    
    define_element("OfficeGPScope")
    
    define_attribute("object_id", required: true)
    define_attribute("name", required: true)
    define_attribute("filingDate", type: "xsd:dateTime")
    define_attribute("incumbentRunning", type: "xsd:boolean")
    define_attribute("localOfficeCode")
    define_attribute("nationalOfficeCode")
    define_attribute("stateOfficeCode")
    define_attribute("partisan", type: "xsd:boolean")
    define_attribute("termStartDate", type: "xsd:date")
    define_attribute("termEndDate", type: "xsd:date")
    define_attribute("unexpiredTerm", type: "xsd:boolean")
    
  end
end