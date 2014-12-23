module VSSC
  class ContestCollection
    include VSSC::ClassAttributes
    define_element("Contest", :multiple=>true, :type=>Contest, :min_size=>1)
  end
end