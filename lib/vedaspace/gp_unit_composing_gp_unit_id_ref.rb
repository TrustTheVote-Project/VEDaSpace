module Vedaspace::GpUnitComposingGpUnitIdRef
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions
  
  included do    
    define_text_node(:composing_gp_unit_id_ref)
  end

end