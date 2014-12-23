module VSSC
  class District < GPUnit
    include VSSC::ClassAttributes
    
    define_attribute("districtType", type: DistrictType, required: true) 
    
  end
end