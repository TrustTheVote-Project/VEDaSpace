module VSSC
  class Device < GPUnit
    include VSSC::ClassAttributes
    
    define_attribute("deviceType", type: DeviceType, required: true)
    define_attribute("manufacturer")
    define_attribute("serialNumber")
    
  end
end