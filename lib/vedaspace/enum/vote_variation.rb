# <xsd:simpleType name="VoteVariation">
#   <xsd:restriction base="xsd:string">
#     <xsd:enumeration value="1-of-m"/>
#     <xsd:enumeration value="approval"/>
#     <xsd:enumeration value="borda"/>
#     <xsd:enumeration value="cumulative"/>
#     <xsd:enumeration value="majority"/>
#     <xsd:enumeration value="n-of-m"/>
#     <xsd:enumeration value="plurality"/>
#     <xsd:enumeration value="proportional"/>
#     <xsd:enumeration value="range"/>
#     <xsd:enumeration value="rcv"/>
#     <xsd:enumeration value="super-majority"/>
#     <xsd:enumeration value="other"/>
#   </xsd:restriction>
# </xsd:simpleType>
class Vedaspace::Enum::VoteVariation
  include Vedaspace::Enum

  set_enum_values "1-of-m",
                  "approval",
                  "borda",
                  "cumulative",
                  "majority",
                  "n-of-m",
                  "plurality",
                  "proportional",
                  "range",
                  "rcv",
                  "super-majority",
                  "other"
  
  
  
                                    
end