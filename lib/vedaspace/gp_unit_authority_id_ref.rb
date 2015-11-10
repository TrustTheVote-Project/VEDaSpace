module Vedaspace::GpUnitAuthorityIdRef
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    self.node_name = 'GpUnitAuthorityIdRef'
    
    define_text_node(:authority_id_ref)
  end
  
end