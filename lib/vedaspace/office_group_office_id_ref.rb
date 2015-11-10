module Vedaspace::OfficeGroupOfficeIdRef
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    self.node_name = 'OfficeGroupOfficeIdRef'
    
    define_text_node(:office_id_ref)
  end

end