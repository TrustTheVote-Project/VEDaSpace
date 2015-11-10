# <xsd:complexType name="OfficeGroup">
#   <xsd:sequence>
#     <xsd:element name="OfficeId" type="xsd:IDREF" minOccurs="0" maxOccurs="unbounded"/>
#     <xsd:element name="SubOfficeGroup" type="OfficeGroup" minOccurs="0" maxOccurs="unbounded"/>
#   </xsd:sequence>
#   <xsd:attribute name="Name" type="xsd:string" use="required"/>
# </xsd:complexType>

# <xsd:complexType name="OfficeGroup">
#   <xsd:sequence>
#     <xsd:element name="Name" type="xsd:string"/>
#     <xsd:element name="OfficeId" type="xsd:IDREF" minOccurs="0" maxOccurs="unbounded"/>
#     <xsd:element name="SubOfficeGroup" type="OfficeGroup" minOccurs="0" maxOccurs="unbounded"/>
#   </xsd:sequence>
#   <xsd:attribute name="label" type="xsd:string"/>
# </xsd:complexType>
module Vedaspace::OfficeGroup
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do  
    self.node_name = 'OfficeGroup'
    
    define_element("Name", required: true)
  
    define_element("OfficeId", type: Vedaspace::OfficeGroupOfficeIdRef, method: :office_group_office_id_refs, multiple: true)
  
    define_element("SubOfficeGroup", type: Vedaspace::OfficeGroup, method: :office_groups, multiple: true)
  
    define_attribute("label")
  end
  
end
