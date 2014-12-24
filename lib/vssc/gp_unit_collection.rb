module VSSC
  class GPUnitCollection
    include VSSC::ClassAttributes
    define_element("GPUnit", :multiple=>true, :type=>GPUnit, :min_size=>1)
  end
end