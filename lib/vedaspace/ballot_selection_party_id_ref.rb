module Vedaspace::BallotSelectionPartyIdRef
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions  
  
  included do
    define_text_node(:party_id_ref)
  end
end