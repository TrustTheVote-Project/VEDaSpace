# <xsd:complexType name="ExternalIdentifiers">
#   <xsd:sequence>
#     <xsd:element name="ExternalIdentifier" maxOccurs="unbounded">
#       <xsd:complexType>
#         <xsd:sequence>
#           <xsd:element name="Type" type="IdentifierType"/>
#           <xsd:element name="OtherType" type="xsd:string" minOccurs="0"/>
#           <xsd:element name="Value" type="xsd:string"/>
#         </xsd:sequence>
#         <xsd:attribute name="label" type="xsd:string"/>
#       </xsd:complexType>
#     </xsd:element>
#   </xsd:sequence>
#   <xsd:attribute name="label" type="xsd:string"/>
# </xsd:complexType>
module Vedaspace::ExternalIdentifierCollection
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    self.node_name = 'ExternalIdentifierCollection'
    
    define_element("ExternalIdentifier", type: Vedaspace::ExternalIdentifier, method: :external_identifiers, multiple: true)

    define_attribute("label")
  end
end