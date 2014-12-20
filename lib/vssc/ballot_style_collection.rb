module VSSC
  class BallotStyleCollection
    include VSSC::ClassAttributes
    define_element("BallotStyle", :multiple=>true, :type=>BallotStyle, :min_size=>1)
  end
end