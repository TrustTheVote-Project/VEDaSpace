module VSSC
  class ElectionReport
  
    include VSSC::ClassAttributes
    define_element("Message")
    define_element("GPUnitCollection", type: GPUnitCollection)
    define_element("PersonCollection", type: PersonCollection)
    define_element("PartyCollection", type: PartyCollection)
    define_element("OfficeCollection", type: OfficeCollection)
    
    define_element("Election", multiple: true)
    
    define_attribute("object_id", required: true)
    define_attribute("date", required: true, type: "xsd:dateTime")
    define_attribute("format", required: true, type: ReportFormat)
    define_attribute("status", required: true, type: ReportStatus)
    define_attribute("issuer", required: true)
    define_attribute("sequence", required: true, type: Fixnum)
    define_attribute("sequenceEnd", required: true, type: Fixnum)
    define_attribute("stateAbbreviation", required: true)
    define_attribute("stateCode")
    define_attribute("vendorApplicationID", required: true)
    
    
    def self.parse_vssc(node)
      e = self.new
      e.set_vssc_attributes(node.attributes)
      e
    end
    
  end
end