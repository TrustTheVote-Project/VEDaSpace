# <xsd:simpleType name="ReportDetailLevel">
#   <xsd:restriction base="xsd:string">
#     <xsd:enumeration value="precinct-level"/>
#     <xsd:enumeration value="summary-contest"/>
#   </xsd:restriction>
# </xsd:simpleType>
class Vedaspace::Enum::ReportDetailLevel
  include Vedaspace::Enum
  
  set_enum_values "precinct-level",
                  "summary-contest"
                  
                  
end

