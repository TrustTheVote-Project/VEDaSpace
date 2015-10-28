# <xsd:simpleType name="ElectionType">
#   <xsd:restriction base="xsd:string">
#     <xsd:enumeration value="general"/>
#     <xsd:enumeration value="partisan-primary-closed"/>
#     <xsd:enumeration value="partisan-primary-open"/>
#     <xsd:enumeration value="primary"/>
#     <xsd:enumeration value="runoff"/>
#     <xsd:enumeration value="special"/>
#     <xsd:enumeration value="other"/>
#   </xsd:restriction>
# </xsd:simpleType>
class Vssc::Enum::ElectionType
  include VsscEnum
  
  set_enum_values "general",
                  "partisan-primary-closed",
                  "partisan-primary-open",
                  "primary",
                  "runoff",
                  "special",
                  "other"
  
  
  
end