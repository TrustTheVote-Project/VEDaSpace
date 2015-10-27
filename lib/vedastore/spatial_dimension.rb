module VSSC
  class SpatialDimension
    include VSSC::ClassAttributes
    define_element("SpatialExtent", type: SpatialExtent)
    define_attribute("object_id", required: true)
    define_attribute("map")
  end
end