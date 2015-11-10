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
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
  
  included do
    self.node_name = 'BallotStyle'

    define_element("ExternalIdentifiers", type: Vedaspace::ExternalIdentifierCollection, method: :external_identifier_collection)
    
    define_element("OrderedContest", method: :ordered_contests, type: Vedaspace::OrderedContest, multiple: true)
    
    define_element("GpUnitId", type: Vedaspace::BallotStyleGpUnitIdRef, method: :ballot_style_gp_unit_id_refs, multiple: true)
    
    define_element("ImageUri")

    define_element("PartyId", type: Vedaspace::BallotStylePartyIdRef, method: :ballot_style_party_id_refs, multiple: true)

    define_attribute("objectId")
  end
end