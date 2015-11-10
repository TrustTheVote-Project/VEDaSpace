# <xsd:complexType name="Device">
#   <xsd:sequence>
#     <xsd:element name="Manufacturer" type="xsd:string" minOccurs="0"/>
#     <xsd:element name="Model" type="xsd:string" minOccurs="0"/>
#     <xsd:element name="Type" type="DeviceType" minOccurs="0"/>
#     <xsd:element name="OtherType" type="xsd:string" minOccurs="0"/>
#   </xsd:sequence>
# </xsd:complexType>
module Vedaspace::Device
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    self.node_name = 'Device'
    
    define_element("Manufacturer")
    define_element("Model")
    define_element("Type", type: Vedaspace::Enum::DeviceType, method: :device_type)
    define_element("OtherType")
  end
end
