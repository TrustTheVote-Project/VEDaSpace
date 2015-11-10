# <xsd:complexType name="BallotSelection" abstract="true">
#   <xsd:sequence>
#     <xsd:element name="SequenceOrder" type="xsd:integer" minOccurs="0"/>
#     <xsd:element name="VoteCountsCollection" minOccurs="0" maxOccurs="unbounded">
#       <xsd:complexType>
#         <xsd:sequence>
#           <xsd:element name="VoteCounts" type="VoteCounts" maxOccurs="unbounded"/>
#         </xsd:sequence>
#       </xsd:complexType>
#     </xsd:element>
#   </xsd:sequence>
#   <xsd:attribute name="objectId" type="xsd:ID" use="required"/>
# </xsd:complexType>
module Vedaspace::BallotSelection
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
  
  included do
    self.node_name = 'BallotSelection'
    define_element("SequenceOrder", type: Fixnum)
    define_element("VoteCountsCollection", type: Vedaspace::VoteCount, method: :counts, passthrough: "VoteCounts", multiple: true)
  
    define_attribute("objectId", :required=>true)
  end
  
end