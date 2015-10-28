# <xsd:simpleType name="ResultsStatus">
#   <xsd:restriction base="xsd:string">
#     <xsd:enumeration value="certified"/>
#     <xsd:enumeration value="correction"/>
#     <xsd:enumeration value="pre-election"/>
#     <xsd:enumeration value="recount"/>
#     <xsd:enumeration value="unofficial-complete"/>
#     <xsd:enumeration value="unofficial-partial"/>
#   </xsd:restriction>
# </xsd:simpleType>
class Vedaspace::Enum::ResultsStatus
  include Vedaspace::Enum
  
  set_enum_values "certified",
                  "correction",
                  "pre-election",
                  "recount",
                  "unofficial-complete",
                  "unofficial-partial"
                  
end

