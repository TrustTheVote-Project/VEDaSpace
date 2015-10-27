module VSSC
  class OfficeCollection
    include VSSC::ClassAttributes
    define_element("Office", :multiple=>true, :type=>Office, :min_size=>1)
    
  end
end