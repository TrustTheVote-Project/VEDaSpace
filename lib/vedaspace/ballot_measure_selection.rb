# <xsd:complexType name="BallotMeasureSelection">
#   <xsd:complexContent>
#     <xsd:extension base="BallotSelection">
#       <xsd:sequence>
#         <xsd:element name="Selection" type="InternationalizedText"/>
#       </xsd:sequence>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>
module Vedaspace::BallotMeasureSelection
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions
  
  included do
    include Vedaspace::BallotSelection
    define_attribute("Selection", type: Vedaspace::InternationalizedText,  belongs_to: true)
  end
  
end
