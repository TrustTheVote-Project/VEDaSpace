# <xsd:simpleType name="DayType">
#   <xsd:restriction base="xsd:string">
#     <xsd:enumeration value="all"/>
#     <xsd:enumeration value="sunday"/>
#     <xsd:enumeration value="monday"/>
#     <xsd:enumeration value="tuesday"/>
#     <xsd:enumeration value="wednesday"/>
#     <xsd:enumeration value="thursday"/>
#     <xsd:enumeration value="friday"/>
#     <xsd:enumeration value="saturday"/>
#     <xsd:enumeration value="weekday"/>
#     <xsd:enumeration value="weekend"/>
#   </xsd:restriction>
# </xsd:simpleType>
class Vedaspace::Enum::DayType
  include Vedaspace::Enum
  
  set_enum_values "all",
                  "sunday",
                  "monday",
                  "tuesday",
                  "wednesday",
                  "thursday",
                  "friday",
                  "saturday",
                  "weekday",
                  "weekend"

end
