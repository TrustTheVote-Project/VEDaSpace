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
    
    define_element("Coordinates", type: "cdata")
    define_element("Format", required: true, type: Vedaspace::Enum::GeoSpatialFormat)
    
    
    # def to_xml_node_with_cdata(xml = nil, node_name = nil)
    #   return to_xml_node_without_shapes(xml, node_name) do |xml|
    #     se.send("Coordinates") do |coo|
    #       coo.cdata(shape_data)
    #     end
    #   end
    # end
    #
    # alias_method_chain :to_xml_node, :shapes
    
    
    
  end
  
end
