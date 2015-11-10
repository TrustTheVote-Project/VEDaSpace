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
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    include Vedaspace::Party
    self.node_name = 'Coalition'
    
    define_element("ContestId", type: Vedaspace::PartyContestIdRef, method: :party_contest_id_refs, multiple: true)
  
    define_element("PartyId", type: Vedaspace::PartyPartyIdRef, method: :party_party_id_refs, multiple: true)
  end
  
end
