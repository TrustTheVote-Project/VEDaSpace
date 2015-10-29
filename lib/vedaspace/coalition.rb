# <xsd:complexType name="Coalition">
#   <xsd:complexContent>
#     <xsd:extension base="Party">
#       <xsd:sequence>
#         <xsd:element name="ContestId" type="xsd:IDREF" minOccurs="0" maxOccurs="unbounded"/>
#         <xsd:element name="PartyId" type="xsd:IDREF" minOccurs="0" maxOccurs="unbounded"/>
#       </xsd:sequence>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>
module Vedaspace::Coalition
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions  
  
  included do
    include Vedaspace::Party
    define_element("ContestId", type: Vedaspace::PartyContestIdRef, method: :party_contest_id_refs)
  
    define_element("PartyId", type: Vedaspace::PartyPartyIdRef, method: :party_party_id_refs)
  end
  
end
