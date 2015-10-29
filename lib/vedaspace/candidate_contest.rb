# <xsd:complexType name="CandidateContest">
#   <xsd:complexContent>
#     <xsd:extension base="Contest">
#       <xsd:sequence>
#         <xsd:element name="NumberElected" type="xsd:integer" minOccurs="0"/>
#         <xsd:element name="OfficeId" type="xsd:IDREF" minOccurs="0" maxOccurs="unbounded"/>
#         <xsd:element name="PrimaryPartyId" type="xsd:IDREF" minOccurs="0"/>
#         <xsd:element name="VotesAllowed" type="xsd:integer"/>
#       </xsd:sequence>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>
module Vedaspace::CandidateContest
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions  
  
  included do
    include Vedaspace::Contest
    
    define_element("NumberElected", type: Fixnum)
    define_element("OfficeId", type: Vssc::ContestOfficeIdRef, method: :contest_office_id_refs)
  
    define_element("PrimaryPartyId", method: :primary_party_identifier)
  
    define_element("VotesAllowed", type: Fixnum, required: true)
  end
  
end