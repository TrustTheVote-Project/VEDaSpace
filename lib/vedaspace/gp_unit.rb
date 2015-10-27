module VSSC
  class GPUnit
    include VSSC::ClassAttributes
    define_element("GPSubUnit", multiple: true, type: GPUnit)
    define_element("GPSubUnitRef", multiple: true)
    define_element("GPUnitTotalCounts", multiple: true, type: TotalCounts)
    define_element("PartyRegistration", type: PartyRegistration)
    define_element("SpatialDimension", multiple: true, type: SpatialDimension)
    
    define_attribute("object_id", required: true)
    define_attribute("URL")
    define_attribute("localGeoCode")
    define_attribute("name")
    define_attribute("nationalGeoCode")
    define_attribute("stateGeoCode")
    
    
  end
end