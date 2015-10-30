module Vedaspace::OfficeGroupOfficeIdRef
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    define_text_node(:office_id_ref)
  end

end