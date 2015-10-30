# <xsd:complexType name="LanguageString">
#   <xsd:simpleContent>
#     <xsd:extension base="xsd:string">
#       <xsd:attribute name="language" type="xsd:language" use="required"/>
#     </xsd:extension>
#   </xsd:simpleContent>
# </xsd:complexType>
module Vedaspace::LanguageString
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    define_attribute("Language") #type: "xsd:language"
    # inner text is actual value
    define_text_node(:text)
  end
end
