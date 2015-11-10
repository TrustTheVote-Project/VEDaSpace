# <xsd:complexType name="Office">
#   <xsd:sequence>
#     <xsd:element name="ContactInformation" type="ContactInformation" minOccurs="0"/>
#     <xsd:element name="ElectoralDistrictId" type="xsd:IDREF" minOccurs="0"/>
#     <xsd:element name="ExternalIdentifiers" type="ExternalIdentifiers" minOccurs="0"/>
#     <xsd:element name="FilingDeadline" type="xsd:date" minOccurs="0"/>
#     <xsd:element name="IsPartisan" type="xsd:boolean" minOccurs="0"/>
#     <xsd:element name="Name" type="InternationalizedText"/>
#     <xsd:element name="OfficeHolderPersonId" type="xsd:IDREF" minOccurs="0" maxOccurs="unbounded"/>
#     <xsd:element name="Term" minOccurs="0">
#       <xsd:complexType>
#         <xsd:sequence>
#           <xsd:element name="StartDate" type="xsd:date" minOccurs="0"/>
#           <xsd:element name="EndDate" type="xsd:date" minOccurs="0"/>
#           <xsd:element name="Type" type="OfficeTermType" minOccurs="0"/>
#         </xsd:sequence>
#         <xsd:attribute name="label" type="xsd:string"/>
#       </xsd:complexType>
#     </xsd:element>
#   </xsd:sequence>
#   <xsd:attribute name="objectId" type="xsd:ID" use="required"/>
# </xsd:complexType>
module Vedaspace::Office
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    self.node_name = 'Office'
  
    define_element("ContactInformation", type: Vedaspace::ContactInformation, belongs_to: true)
    define_element("ElectoralDistrictId", method: :electoral_district_identifier)
  
    define_element("ExternalIdentifiers", type: Vedaspace::ExternalIdentifierCollection, method: :external_identifier_collection)
  
    define_element("FilingDeadline", type: "xsd:date")
    define_element("IsPartisan", type: "xsd:boolean")
    define_element("Name", type: Vedaspace::InternationalizedText, belongs_to: true)
  
    define_element("OfficeHolderId", type: Vedaspace::OfficeOfficeHolderIdRef, method: :office_office_holder_id_refs, multiple: true)
  
    define_element("Term", type: Vedaspace::Term, belongs_to: true)
  
    define_attribute("objectId", required: true)
  end  
  
end
