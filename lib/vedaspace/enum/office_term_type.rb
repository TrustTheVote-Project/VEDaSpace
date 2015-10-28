# <xsd:simpleType name="OfficeTermType">
#   <xsd:restriction base="xsd:string">
#     <xsd:enumeration value="full-term"/>
#     <xsd:enumeration value="unexpired-term"/>
#   </xsd:restriction>
# </xsd:simpleType>
class Vedaspace::Enum::OfficeTermType
  include Vedaspace::Enum
  
  set_enum_values "full-term",
                  "unexpired-term"
                  
end
