module VSSC
  class BallotMeasureSelection < VSSC::BallotSelection
    define_attribute("selection", {:required=>true})
  end
end