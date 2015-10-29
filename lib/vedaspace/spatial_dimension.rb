# <xsd:complexType name="SpatialDimension">
#   <xsd:sequence>
#     <xsd:element name="MapUri" type="xsd:anyURI" minOccurs="0"/>
#     <xsd:element name="SpatialExtent" type="SpatialExtent" minOccurs="0"/>
#   </xsd:sequence>
# </xsd:complexType>
module Vedaspace::SpatialDimension
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions
  
  included do
    define_element("MapUri")
    define_element("SpatialExtent", type: Vedaspace::SpatialExtent, belongs_to: true)  
  end
  
end
