module VSSC
  class BallotStyle
    include VSSC::ClassAttributes
    define_element("OrderedContest", :multiple=>true, :type=>OrderedContest)
    define_element("GPUnit")
    define_attribute("object_id", :required=>true)
    define_attribute("ballotStyleID")
    
  end
end