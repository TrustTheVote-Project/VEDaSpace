# <xsd:complexType name="OrderedContest">
#   <xsd:sequence>
#     <xsd:element name="ContestId" type="xsd:IDREF"/>
#     <xsd:element name="OrderedBallotSelectionId" type="xsd:IDREF" minOccurs="0" maxOccurs="unbounded"/>
#   </xsd:sequence>
# </xsd:complexType>
module Vedaspace::OrderedContest
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions  
  
  included do
    define_element("ContestId", method: :contest_identifier)

    define_element("OrderedBallotSelectionId", type: Vedaspace::OrderedContestBallotSelectionIdRef, method: :ordered_contest_ballot_selection_id_refs)
  
  end  
end
