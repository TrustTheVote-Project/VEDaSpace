# <xsd:complexType name="SpatialExtent">
#   <xsd:sequence>
#     <xsd:element name="Coordinates" type="xsd:string"/>
#     <xsd:element name="Format" type="GeoSpatialFormat"/>
#   </xsd:sequence>
# </xsd:complexType>
module Vedaspace::SpatialExtent
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions
  
  included do
    define_element("Coordinates")
    define_element("Format", required: true, type: Vedaspace::Enum::GeoSpatialFormat)
  end
  
end
