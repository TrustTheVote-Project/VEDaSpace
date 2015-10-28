# <xsd:simpleType name="CandidatePostElectionStatus">
#   <xsd:restriction base="xsd:string">
#     <xsd:enumeration value="advanced-to-runoff"/>
#     <xsd:enumeration value="projected-winner"/>
#     <xsd:enumeration value="winner"/>
#     <xsd:enumeration value="withdrawn"/>
#   </xsd:restriction>
# </xsd:simpleType>
class Vedaspace::Enum::CandidatePostElectionStatus
  include Vedaspace::Enum
  
  set_enum_values "advanced-to-runoff",
                  "projected-winner",
                  "winner",
                  "withdrawn"
  
  

end
