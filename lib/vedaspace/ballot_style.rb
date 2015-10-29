# <xsd:complexType name="BallotStyle">
#   <xsd:sequence>
#     <xsd:element name="ExternalIdentifiers" type="ExternalIdentifiers" minOccurs="0"/>
#     <xsd:element name="GpUnitId" type="xsd:IDREF" maxOccurs="unbounded"/>
#     <xsd:element name="ImageUri" type="xsd:anyURI" minOccurs="0" maxOccurs="unbounded"/>
#     <xsd:element name="OrderedContest" type="OrderedContest" minOccurs="0" maxOccurs="unbounded"/>
#     <xsd:element name="PartyId" type="xsd:IDREF" minOccurs="0" maxOccurs="unbounded"/>
#   </xsd:sequence>
#   <xsd:attribute name="objectId" type="xsd:ID" use="required"/>
# </xsd:complexType>
module Vedaspace::BallotStyle
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions  
  
  included do

    define_element("ExternalIdentifiers", type: Vedaspace::ExternalIdentifierCollection, method: :external_identifier_collection)
    
    define_element("OrderedContest", method: :ordered_contests, type: Vedaspace::OrderedContest)
    
    define_element("GpUnitId", type: Vedaspace::BallotStyleGpUnitIdRef, method: :ballot_style_gp_unit_id_refs)
    
    define_element("ImageUri")

    define_element("PartyId", type: Vedaspace::BallotStylePartyIdRef, method: :ballot_style_party_id_refs)

    define_attribute("objectId")
  end
end