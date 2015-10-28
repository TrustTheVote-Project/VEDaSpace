# <xsd:simpleType name="OfficeCategory">
#   <xsd:restriction base="xsd:string">
#     <xsd:enumeration value="CountyWide"/>
#     <xsd:enumeration value="Judicial"/>
#     <xsd:enumeration value="StateWide"/>
#   </xsd:restriction>
# </xsd:simpleType>
class Vedaspace::Enum::OfficeCategory
  include Vedaspace::Enum
  
  set_enum_values "CountyWide",
                  "Judicial",
                  "StateWide"
                  
end
