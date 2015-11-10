# <xsd:complexType name="SpatialExtent">
#   <xsd:sequence>
#     <xsd:element name="Coordinates" type="xsd:string"/>
#     <xsd:element name="Format" type="GeoSpatialFormat"/>
#   </xsd:sequence>
# </xsd:complexType>
module Vedaspace::SpatialExtent
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    self.node_name = 'SpatialExtent'
    
    define_element("Coordinates")
    define_element("Format", required: true, type: Vedaspace::Enum::GeoSpatialFormat)
  end
  
end
