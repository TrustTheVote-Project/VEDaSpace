module Vedaspace::BallotSelectionEndorsementPartyIdRef
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
  
  included do
    define_text_node(:endorsement_party_id_ref)
  end  

end