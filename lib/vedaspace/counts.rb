module VSSC
  class Counts
    include VSSC::ClassAttributes
    
    define_element("GPUnit")
    define_attribute("object_id", required: true)
    define_attribute("ballotType", type: BallotType)
    
    define_attribute("deviceManufacturer")
    define_attribute("deviceModel")
    define_attribute("deviceType", type: DeviceType)
    
  end
end