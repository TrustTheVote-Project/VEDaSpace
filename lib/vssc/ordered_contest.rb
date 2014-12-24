module VSSC
  class OrderedContest
    include VSSC::ClassAttributes
    define_element("Contest")
    define_element("BallotSelection", multiple: true)
    define_attribute("object_id", required: true)
  end
end