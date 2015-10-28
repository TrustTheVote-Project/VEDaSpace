# <xsd:simpleType name="GeoSpatialFormat">
#   <xsd:restriction base="xsd:string">
#     <xsd:enumeration value="geo-json"/>
#     <xsd:enumeration value="gml"/>
#     <xsd:enumeration value="kml"/>
#     <xsd:enumeration value="shp"/>
#     <xsd:enumeration value="wkt"/>
#   </xsd:restriction>
# </xsd:simpleType>
class Vedaspace::Enum::GeoSpatialFormat
  include Vedaspace::Enum
  
  set_enum_values "geo-json",
                  "gml",
                  "kml",
                  "shp",
                  "wkt"
                  
end