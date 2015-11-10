# <xsd:complexType name="AnnotatedString">
#   <xsd:simpleContent>
#     <xsd:extension base="xsd:string">
#       <xsd:attribute name="annotation" type="ShortString"/>
#     </xsd:extension>
#   </xsd:simpleContent>
# </xsd:complexType>
module Vedaspace::AnnotatedString
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions
  
  included do
    self.node_name = 'AnnotatedString'
    
    define_text_node("value")
    define_attribute("annotation")
  end
  
end
