# <xsd:complexType name="CandidateSelection">
#   <xsd:complexContent>
#     <xsd:extension base="BallotSelection">
#       <xsd:sequence>
#         <xsd:element name="CandidateId" type="xsd:IDREF" maxOccurs="unbounded"/>
#         <xsd:element name="EndorsementPartyId" type="xsd:IDREF" minOccurs="0" maxOccurs="unbounded"/>
#         <xsd:element name="IsWriteIn" type="xsd:boolean" minOccurs="0"/>
#       </xsd:sequence>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>
module Vedaspace::CandidateSelection
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions  
  
  included do
    include Vedaspace::BallotSelection
    define_element("CandidateId", type: Vssc::BallotSelectionCandidateIdRef, method: :ballot_selection_candidate_id_refs)
  
    define_element("EndorsementPartyId", type: Vssc::BallotSelectionEndorsementPartyIdRef, method: :ballot_selection_endorsement_party_id_refs)
  
    define_element("IsWriteIn", type: "xsd:boolean", method: :is_write_in)
  end  
  
end
