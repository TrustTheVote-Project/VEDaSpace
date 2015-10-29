module Vedaspace::BallotSelectionEndorsementPartyIdRef
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions  
  
  included do
    define_text_node(:endorsement_party_id_ref)
  end  

end