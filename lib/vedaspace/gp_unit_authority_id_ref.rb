module Vedaspace::GpUnitAuthorityIdRef
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    define_text_node(:authority_id_ref)
  end
  
end