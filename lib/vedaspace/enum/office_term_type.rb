# <xsd:simpleType name="OfficeTermType">
#   <xsd:restriction base="xsd:string">
#     <xsd:enumeration value="full-term"/>
#     <xsd:enumeration value="unexpired-term"/>
#   </xsd:restriction>
# </xsd:simpleType>
class Vssc::Enum::OfficeTermType
  include VsscEnum
  
  set_enum_values "full-term",
                  "unexpired-term"
                  
end
