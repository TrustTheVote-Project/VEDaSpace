# <xsd:complexType name="Party">
#   <xsd:sequence>
#     <xsd:element name="Abbreviation" type="xsd:string" minOccurs="0"/>
#     <xsd:element name="Color" type="HtmlColorString" minOccurs="0"/>
#     <xsd:element name="ExternalIdentifiers" type="ExternalIdentifiers" minOccurs="0"/>
#     <xsd:element name="LogoUri" type="xsd:anyURI" minOccurs="0"/>
#     <xsd:element name="Name" type="InternationalizedText"/>
#   </xsd:sequence>
#   <xsd:attribute name="objectId" type="xsd:ID" use="required"/>
# </xsd:complexType>
module Vedaspace::Party
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions
  
  included do
    define_element("Abbreviation")
    define_element("Color")

    define_element("ExternalIdentifiers", type: Vedaspace::ExternalIdentifierCollection, method: :external_identifier_collection)

    define_element("LogoUri")
  
    define_element("Name", type: Vedaspace::InternationalizedText, belongs_to: true)

    define_attribute("objectId", required: true)
  end  
end
