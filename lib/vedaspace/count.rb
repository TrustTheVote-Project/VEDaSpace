# <xsd:complexType name="Counts" abstract="true">
#   <xsd:sequence>
#     <xsd:element name="Device" type="Device" minOccurs="0"/>
#     <xsd:element name="GpUnitId" type="xsd:IDREF" minOccurs="0"/>
#     <xsd:element name="IsSuppressedForPrivacy" type="xsd:boolean" minOccurs="0"/>
#     <xsd:element name="Type" type="CountItemType" minOccurs="0"/>
#     <xsd:element name="OtherType" type="xsd:string" minOccurs="0"/>
#   </xsd:sequence>
# </xsd:complexType>
module Vedaspace::Count
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do  
    self.node_name = 'Count'
    
    define_element("Device", type: Vedaspace::Device, belongs_to: true)
    define_element("GpUnitId", method: :gp_unit_identifier)
    define_element("IsSuppressedForPrivacy", type: "xsd:boolean")
    define_element("Type", type: Vedaspace::Enum::CountItemType, method: :count_item_type)
    define_element("OtherType")
  end
end
