module Vedaspace::BallotSelectionCandidateIdRef
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions  
  
  included do
    define_text_node(:candidate_id_ref)
  end  

end