module Vedaspace::ContestOfficeIdRef
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    self.node_name = 'ContestOfficeIdRef'
    
    define_text_node(:office_id_ref)
  end
  
end