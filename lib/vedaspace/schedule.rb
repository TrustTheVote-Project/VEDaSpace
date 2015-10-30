# <xsd:complexType name="Schedule">
#   <xsd:sequence>
#     <xsd:element name="Hours" type="Hours" minOccurs="0" maxOccurs="unbounded"/>
#     <xsd:element name="IsOnlyByAppointment" type="xsd:boolean" minOccurs="0"/>
#     <xsd:element name="IsOrByAppointment" type="xsd:boolean" minOccurs="0"/>
#     <xsd:element name="IsSubjectToChange" type="xsd:boolean" minOccurs="0"/>
#     <xsd:element name="StartDate" type="xsd:date" minOccurs="0"/>
#     <xsd:element name="EndDate" type="xsd:date" minOccurs="0"/>
#   </xsd:sequence>
#   <xsd:attribute name="label" type="xsd:string"/>
# </xsd:complexType>
module Vedaspace::Schedule
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do  
    define_element("Hours", type: Vedaspace::Hour, method: :hours)
  
    define_attribute("IsOnlyByAppointment", type: "xsd:boolean")
    define_attribute("IsOrByAppointment", type: "xsd:boolean")
    define_attribute("IsSubjectToChange", type: "xsd:boolean")

    define_attribute("StartDate", type: Date)
    define_attribute("EndDate", type: Date)
  
    define_attribute("label")
  end
  
end
