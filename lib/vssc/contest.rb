module VSSC
  class Contest
    include VSSC::ClassAttributes
    
    define_element("BallotSelection", multiple: true)
    define_element("ContestGPScope")
    define_element("ContestTotalCounts", multiple: true)
    define_element("ContestTotalCountsByGPUnit", multiple: true)
    
    define_attribute("object_id", required: true)
    define_attribute("abbreviation")
    define_attribute("localContestCode")
    define_attribute("name", required: true)
    define_attribute("nationalContestCode")
    define_attribute("reportedPrecincts", type: Fixnum)
    define_attribute("sequenceOrder", type: Fixnum)
    define_attribute("stateContestCode")
    define_attribute("totalPrecincts", type: Fixnum)
    define_attribute("voteVariation", type: VoteVariation )
  end
end