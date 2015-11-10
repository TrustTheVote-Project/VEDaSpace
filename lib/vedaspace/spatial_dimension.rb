# <xsd:complexType name="SpatialDimension">
#   <xsd:sequence>
#     <xsd:element name="MapUri" type="xsd:anyURI" minOccurs="0"/>
#     <xsd:element name="SpatialExtent" type="SpatialExtent" minOccurs="0"/>
#   </xsd:sequence>
# </xsd:complexType>
module Vedaspace::SpatialDimension
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    self.node_name = 'SpatialDimension'
    
    define_element("MapUri")
    define_element("SpatialExtent", type: Vedaspace::SpatialExtent, belongs_to: true)  
  end
  
end
