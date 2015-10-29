module Vedastore::OrderedContestBallotSelectionIdRef
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions  

  included do
    define_text_node(:ballot_selection_id_ref)  
  end

end