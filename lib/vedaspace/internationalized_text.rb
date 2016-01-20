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
    self.node_name = 'InternationalizedText'
    
    define_element("Text", type: Vedaspace::LanguageString, method: :language_strings, multiple: true)
    define_attribute("label")
    
    def to_s(locale='en')
      ls = language_strings.where(language: locale).first
      ls ? ls.text : nil
    end
    
  end
  
end
