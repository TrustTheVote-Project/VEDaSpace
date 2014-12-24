module VSSC
  class PartyCollection
    include VSSC::ClassAttributes
    define_element("Party", :multiple=>true, :type=>Party, :min_size=>1)
    
  end
end