module VSSC
  class SpatialExtent
    include VSSC::ClassAttributes
    define_element("Coordinates")
    define_attribute("object_id", required: true)
    define_attribute("format", required: true)
  end
end