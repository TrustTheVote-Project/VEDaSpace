# <xsd:complexType name="VoteCounts">
#   <xsd:complexContent>
#     <xsd:extension base="Counts">
#       <xsd:sequence>
#         <xsd:element name="Count" type="xsd:float"/>
#       </xsd:sequence>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>
module Vedaspace::VoteCount
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions
  
  included do
    include Vedaspace::Count
    define_element("Count", type: Float, required: true)
  end
  
end
