module Vedaspace::OrderedContestBallotSelectionIdRef
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
  
  included do
    define_text_node(:ballot_selection_id_ref)  
  end

end