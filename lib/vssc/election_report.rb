module VSSC
  class ElectionReport
  
    include VSSC::ClassAttributes
    define_element("Message")
    define_element("GPUnitCollection", type: GPUnitCollection)
    define_element("PersonCollection", type: PersonCollection)
    define_element("PartyCollection", type: PartyCollection)
    define_element("OfficeCollection", type: OfficeCollection)
    
    define_element("Election", multiple: true, type: Election)
    
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
    
    # root node extra attributes
    # xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://grouper.ieee.org/groups/1622/fake_url" xsi:schemaLocation="http://grouper.ieee.org/groups/1622/fake_url file:///G:/1622.2/ElectionResultsV29.xsd"
    
    def xml_attributes_hash_with_root(node_name)
      attr_hash = xml_attributes_hash_without_root(node_name)
      attr_hash['xmlns:xsi'] = "http://www.w3.org/2001/XMLSchema-instance"
      attr_hash['xmlns'] = "http://grouper.ieee.org/groups/1622/fake_url"
      attr_hash['xsi:schemaLocation'] = "http://grouper.ieee.org/groups/1622/fake_url file:///G:/1622.2/ElectionResultsV29.xsd"
      return attr_hash
    end
    
     alias_method_chain :xml_attributes_hash, :root
    
  end
end