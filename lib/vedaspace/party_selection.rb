# <xsd:complexType name="PartySelection">
#   <xsd:complexContent>
#     <xsd:extension base="BallotSelection">
#       <xsd:sequence>
#         <xsd:element name="PartyId" type="xsd:IDREF" maxOccurs="unbounded"/>
#       </xsd:sequence>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>
module Vedaspace::PartySelection
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    include Vedaspace::BallotSelection
    self.node_name = 'PartySelection'
    
    define_element("PartyId", type: Vedaspace::BallotSelectionPartyIdRef, method: :ballot_selection_party_id_refs, multiple: true)
  end  
end
