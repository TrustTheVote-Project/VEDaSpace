module Vedaspace::BallotStylePartyIdRef
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
  
  included do
    self.node_name = 'BallotStylePartyIdRef'
    define_text_node(:party_id_ref)
  end

end