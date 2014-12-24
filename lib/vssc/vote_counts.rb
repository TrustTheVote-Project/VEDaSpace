module VSSC
  class VoteCounts < Counts
    include VSSC::ClassAttributes
    define_attribute("count", type: Float)
  end
end