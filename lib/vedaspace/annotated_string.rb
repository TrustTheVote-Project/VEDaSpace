# <xsd:complexType name="AnnotatedString">
#   <xsd:simpleContent>
#     <xsd:extension base="xsd:string">
#       <xsd:attribute name="annotation" type="ShortString"/>
#     </xsd:extension>
#   </xsd:simpleContent>
# </xsd:complexType>
module Vedaspace::AnnotatedString
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions
  
  included do
    define_text_node("value")
    define_attribute("annotation")
  end
  
end
