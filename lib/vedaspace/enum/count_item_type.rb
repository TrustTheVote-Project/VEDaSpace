# <xsd:simpleType name="CountItemType">
#   <xsd:restriction base="xsd:string">
#     <xsd:enumeration value="absentee"/>
#     <xsd:enumeration value="absentee-fwab"/>
#     <xsd:enumeration value="absentee-in-person"/>
#     <xsd:enumeration value="absentee-mail"/>
#     <xsd:enumeration value="early"/>
#     <xsd:enumeration value="election-day"/>
#     <xsd:enumeration value="provisional"/>
#     <xsd:enumeration value="total"/>
#     <xsd:enumeration value="uocava"/>
#     <xsd:enumeration value="write-in"/>
#     <xsd:enumeration value="other"/>
#   </xsd:restriction>
# </xsd:simpleType>
class Vssc::Enum::CountItemType
  include VsscEnum
  
  set_enum_values "absentee",
                  "absentee-fwab",
                  "absentee-in-person",
                  "absentee-mail",
                  "early",
                  "election-day",
                  "provisional",
                  "total",
                  "uocava",
                  "write-in",
                  "other"
  
                  
end
