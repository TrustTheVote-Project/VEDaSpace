# <xsd:complexType name="ElectionReport">
#   <xsd:sequence>
#     <xsd:element name="Election" type="Election" minOccurs="0" maxOccurs="unbounded"/>
#     <xsd:element name="ExternalIdentifiers" type="ExternalIdentifiers" minOccurs="0"/>
#     <xsd:element name="Format" type="ReportDetailLevel"/>
#     <xsd:element name="GeneratedDate" type="xsd:dateTime"/>
#     <xsd:element name="GpUnitCollection" minOccurs="0" maxOccurs="unbounded">
#       <xsd:complexType>
#         <xsd:sequence>
#           <xsd:element name="GpUnit" type="GpUnit" maxOccurs="unbounded"/>
#         </xsd:sequence>
#       </xsd:complexType>
#     </xsd:element>
#     <xsd:element name="Issuer" type="xsd:string"/>
#     <xsd:element name="IssuerAbbreviation" type="xsd:string"/>
#     <xsd:element name="IsTest" type="xsd:boolean" minOccurs="0"/>
#     <xsd:element name="Notes" type="xsd:string" minOccurs="0"/>
#     <xsd:element name="OfficeCollection" minOccurs="0" maxOccurs="unbounded">
#       <xsd:complexType>
#         <xsd:sequence>
#           <xsd:element name="Office" type="Office" maxOccurs="unbounded"/>
#           <xsd:element name="OfficeGroup" type="OfficeGroup" minOccurs="0" maxOccurs="unbounded"/>
#         </xsd:sequence>
#       </xsd:complexType>
#     </xsd:element>
#     <xsd:element name="PartyCollection" minOccurs="0" maxOccurs="unbounded">
#       <xsd:complexType>
#         <xsd:sequence>
#           <xsd:element name="Party" type="Party" maxOccurs="unbounded"/>
#         </xsd:sequence>
#       </xsd:complexType>
#     </xsd:element>
#     <xsd:element name="PersonCollection" minOccurs="0" maxOccurs="unbounded">
#       <xsd:complexType>
#         <xsd:sequence>
#           <xsd:element name="Person" type="Person" maxOccurs="unbounded"/>
#         </xsd:sequence>
#       </xsd:complexType>
#     </xsd:element>
#     <xsd:element name="SequenceStart" type="xsd:integer"/>
#     <xsd:element name="SequenceEnd" type="xsd:integer"/>
#     <xsd:element name="Status" type="ResultsStatus"/>
#     <xsd:element name="TestType" type="xsd:string" minOccurs="0"/>
#     <xsd:element name="VendorApplicationId" type="xsd:string"/>
#     <xsd:element ref="ds:Signature" minOccurs="0"/>
#   </xsd:sequence>
# </xsd:complexType>
require 'csv'
module Vedaspace::ElectionReport
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions
  
  included do
    
    # TODO: Election should be multiple??
    define_element("Election", type: Vedaspace::Election, belongs_to: true)

    define_element("ExternalIdentifiers", type: Vedaspace::ExternalIdentifierCollection, method: :external_identifier_collection)
    
    define_element("Format", type: Vedaspace::Enum::ReportDetailLevel)
    define_element("GeneratedDate", type: "xsd:dateTime")

    define_element("GpUnitCollection", type: Vedaspace::GpUnit, method: :gp_units, passthrough: "GpUnit")
    
    define_element("Issuer", required: true)
    define_element("IssuerAbbreviation", required: true)
    define_element("IsTest", type: "xsd:boolean")
    define_element("Notes")

    # need Office / OfficeGroup
    define_element("OfficeCollection", type: Vedaspace::Office, method: :offices, passthrough: "Office")
    
    define_element("PartyCollection", type: Vedaspace::Party, method: :parties, passthrough: "Party")
    
    define_element("PersonCollection", type: Vedaspace::Person, method: :people, passthrough: "Person")     

    define_element("SequenceStart", type: Fixnum)
    define_element("SequenceEnd", type: Fixnum)
    define_element("Status", type: Vedaspace::Enum::ResultsStatus)
    define_element("TestType")
    define_element("VendorApplicationId", method: :vendor_application_identifier)

    alias_method_chain :xml_attributes_hash, :root

  end
  
  def xml_attributes_hash_with_root(node_name)
    attr_hash = xml_attributes_hash_without_root(node_name)
    attr_hash['xmlns:xsi'] = "http://www.w3.org/2001/XMLSchema-instance"
    attr_hash['xmlns'] = "http://grouper.ieee.org/groups/1622/groups/2/V1/1622_2-election_results_reporting.xsd"
    attr_hash['xsi:schemaLocation'] = "http://grouper.ieee.org/groups/1622/groups/2/V1/1622_2-election_results_reporting.xsd http://grouper.ieee.org/groups/1622/groups/2/V1/1622_2-election_results_reporting.xsd"
    return attr_hash
  end

end