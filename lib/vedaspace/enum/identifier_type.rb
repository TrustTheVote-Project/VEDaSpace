# <xsd:simpleType name="IdentifierType">
#   <xsd:restriction base="xsd:string">
#     <xsd:enumeration value="fips"/>
#     <xsd:enumeration value="local-level"/>
#     <xsd:enumeration value="national-level"/>
#     <xsd:enumeration value="ocd-id"/>
#     <xsd:enumeration value="state-level"/>
#     <xsd:enumeration value="other"/>
#   </xsd:restriction>
# </xsd:simpleType>
class Vssc::Enum::IdentifierType
  include VsscEnum
  
  set_enum_values "fips",
                  "local-level",
                  "national-level",
                  "ocd-id",
                  "state-level",
                  "other"
                  
end