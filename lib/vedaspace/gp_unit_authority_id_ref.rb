module Vedaspace::GpUnitAuthorityIdRef
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions
  
  included do
    define_text_node(:authority_id_ref)
  end
  
end