# <xsd:simpleType name="CountItemStatus">
#   <xsd:restriction base="xsd:string">
#     <xsd:enumeration value="completed"/>
#     <xsd:enumeration value="in-process"/>
#     <xsd:enumeration value="not-processed"/>
#     <xsd:enumeration value="unknown"/>
#   </xsd:restriction>
# </xsd:simpleType>
class Vssc::Enum::CountItemStatus
  include VsscEnum
  
  set_enum_values "completed",
                  "in-process",
                  "not-processed",
                  "unknown"
                  
end