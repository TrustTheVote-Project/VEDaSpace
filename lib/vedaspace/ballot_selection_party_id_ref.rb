module Vedaspace::BallotSelectionPartyIdRef
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    self.node_name = 'BallotSelectionPartyIdRef'
    define_text_node(:party_id_ref)
  end
end