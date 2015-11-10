module Vedaspace::GpUnitComposingGpUnitIdRef
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do    
    self.node_name = 'GpUnitComposingGpUnitIdRef'
    
    define_text_node(:composing_gp_unit_id_ref)
  end

end