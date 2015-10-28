# <xsd:simpleType name="CandidatePreElectionStatus">
#   <xsd:restriction base="xsd:string">
#     <xsd:enumeration value="filed"/>
#     <xsd:enumeration value="qualified"/>
#     <xsd:enumeration value="withdrawn"/>
#     <xsd:enumeration value="write-in"/>
#   </xsd:restriction>
# </xsd:simpleType>
class Vssc::Enum::CandidatePreElectionStatus
  include VsscEnum
  
  set_enum_values "filed",
                  "qualified",
                  "withdrawn",
                  "write-in"

end
