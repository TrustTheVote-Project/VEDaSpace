# <xsd:simpleType name="ReportingUnitType">
#   <xsd:restriction base="xsd:string">
#     <xsd:enumeration value="ballot-batch"/>
#     <xsd:enumeration value="ballot-style-area"/>
#     <xsd:enumeration value="city"/>
#     <xsd:enumeration value="city-council"/>
#     <xsd:enumeration value="combined-precinct"/>
#     <xsd:enumeration value="congressional"/>
#     <xsd:enumeration value="county"/>
#     <xsd:enumeration value="county-council"/>
#     <xsd:enumeration value="drop-box"/>
#     <xsd:enumeration value="judicial"/>
#     <xsd:enumeration value="municipality"/>
#     <xsd:enumeration value="polling-place"/>
#     <xsd:enumeration value="precinct"/>
#     <xsd:enumeration value="school"/>
#     <xsd:enumeration value="special"/>
#     <xsd:enumeration value="split-precinct"/>
#     <xsd:enumeration value="state"/>
#     <xsd:enumeration value="state-house"/>
#     <xsd:enumeration value="state-senate"/>
#     <xsd:enumeration value="town"/>
#     <xsd:enumeration value="township"/>
#     <xsd:enumeration value="utility"/>
#     <xsd:enumeration value="village"/>
#     <xsd:enumeration value="vote-center"/>
#     <xsd:enumeration value="ward"/>
#     <xsd:enumeration value="water"/>
#     <xsd:enumeration value="other"/>
#   </xsd:restriction>
# </xsd:simpleType>
class Vedaspace::Enum::ReportingUnitType
  include Vedaspace::Enum
  
  set_enum_values "ballot-batch",
                  "ballot-style-area",
                  "city",
                  "city-council",
                  "combined-precinct",
                  "congressional",
                  "county",
                  "county-council",
                  "drop-box",
                  "judicial",
                  "municipality",
                  "polling-place",
                  "precinct",
                  "school",
                  "special",
                  "split-precinct",
                  "state",
                  "state-house",
                  "state-senate",
                  "town",
                  "township",
                  "utility",
                  "village",
                  "vote-center",
                  "ward",
                  "water",
                  "other"
  
  
end 