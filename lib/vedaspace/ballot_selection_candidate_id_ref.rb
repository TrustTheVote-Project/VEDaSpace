module Vedaspace::BallotSelectionCandidateIdRef
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
  
  included do
    define_text_node(:candidate_id_ref)
  end  

end