module Vedaspace::BallotSelectionCandidateIdRef
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
  
  included do
    self.node_name = 'BallotSelectionCandidateIdRef'

    define_text_node(:candidate_id_ref)
  end  

end