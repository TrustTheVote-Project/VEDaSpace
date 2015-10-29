# <xsd:complexType name="SummaryCounts">
#   <xsd:complexContent>
#     <xsd:extension base="Counts">
#       <xsd:sequence>
#         <xsd:element name="BallotsCast" type="xsd:integer" minOccurs="0"/>
#         <xsd:element name="BallotsOutstanding" type="xsd:integer" minOccurs="0"/>
#         <xsd:element name="BallotsRejected" type="xsd:integer" minOccurs="0"/>
#         <xsd:element name="Overvotes" type="xsd:integer" minOccurs="0"/>
#         <xsd:element name="Undervotes" type="xsd:integer" minOccurs="0"/>
#         <xsd:element name="WriteIns" type="xsd:integer" minOccurs="0"/>
#       </xsd:sequence>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>
module Vedaspace::SummaryCounts
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions  
  
  included do
    belongs_to :summary_countable, polymorphic: true
  
    define_element("BallotsCast", type: Fixnum)
    define_element("BallotsOutstanding", type: Fixnum)
    define_element("BallotsRejected", type: Fixnum)
    define_element("Overvotes", type: Fixnum)
    define_element("Undervotes", type: Fixnum)
    define_element("WriteIns", type: Fixnum)
  end  
end
