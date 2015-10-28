# <xsd:simpleType name="OfficeCategory">
#   <xsd:restriction base="xsd:string">
#     <xsd:enumeration value="CountyWide"/>
#     <xsd:enumeration value="Judicial"/>
#     <xsd:enumeration value="StateWide"/>
#   </xsd:restriction>
# </xsd:simpleType>
class Vssc::Enum::OfficeCategory
  include VsscEnum
  
  set_enum_values "CountyWide",
                  "Judicial",
                  "StateWide"
                  
end
