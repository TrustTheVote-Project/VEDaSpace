# <xsd:complexType name="InternationalizedText">
#   <xsd:sequence>
#     <xsd:element name="Text" type="LanguageString" maxOccurs="unbounded"/>
#   </xsd:sequence>
#   <xsd:attribute name="label" type="xsd:string"/>
# </xsd:complexType>
module Vedaspace::InternationalizedText
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    define_element("Text", type: Vedaspace::LanguageString, method: :language_strings)
    define_attribute("label")
  end
  
end
