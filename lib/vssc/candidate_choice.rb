module VSSC
  class CandidateChoice < Contest
    include VSSC::ClassAttributes
    define_element("Office")
    define_element("PrimaryParty")
    
    define_attribute("numberElected", type: Fixnum)
    define_attribute("votesAllowed", type: Fixnum, required: true)
  end
end