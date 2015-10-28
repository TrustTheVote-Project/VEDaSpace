# <xsd:simpleType name="ReportDetailLevel">
#   <xsd:restriction base="xsd:string">
#     <xsd:enumeration value="precinct-level"/>
#     <xsd:enumeration value="summary-contest"/>
#   </xsd:restriction>
# </xsd:simpleType>
class Vssc::Enum::ReportDetailLevel
  include VsscEnum
  
  set_enum_values "precinct-level",
                  "summary-contest"
                  
                  
end

