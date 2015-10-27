module VSSC
  class BallotSelection
    include VSSC::ClassAttributes
    define_element("VoteCounts", :multiple=>true, :type=>VoteCounts)
    define_attribute("object_id", :required=>true)
    define_attribute("ballotSelectionID")
  end
end