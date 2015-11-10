# <xsd:complexType name="ReportingDevice">
#   <xsd:complexContent>
#     <xsd:extension base="GpUnit">
#       <xsd:sequence>
#         <xsd:element name="Device" type="Device" minOccurs="0"/>
#         <xsd:element name="SerialNumber" type="xsd:string" minOccurs="0"/>
#       </xsd:sequence>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>
module Vedaspace::ReportingDevice
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    include Vedaspace::GpUnit
    self.node_name = 'ReportingDevice'
    
    define_element("Device", type: Vedaspace::Device, belongs_to: true)
    define_element("SerialNumber")
  end
  
end

