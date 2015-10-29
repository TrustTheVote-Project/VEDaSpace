# <xsd:complexType name="Hours">
#   <xsd:sequence>
#     <xsd:element name="Day" type="DayType" minOccurs="0"/>
#     <xsd:element name="StartTime" type="TimeWithZone"/>
#     <xsd:element name="EndTime" type="TimeWithZone"/>
#   </xsd:sequence>
#   <xsd:attribute name="label" type="xsd:string"/>
# </xsd:complexType>
module Vedaspace::Hours
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions  
  
  included do  

    belongs_to :hourable, polymorphic: true
  
    define_element("Day", type: Vedaspace::Enum::DayType, required: true)
    define_element("StartTime", type: DateTime, required: true)
    define_element("EndTime", type: DateTime, required: true)
  
    define_attribute("label")
  end
  
end
