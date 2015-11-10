module Vedaspace::PartyPartyIdRef
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    self.node_name = 'PartyPartyIdRef'
    
    define_text_node(:party_id_ref)
  end
  

end