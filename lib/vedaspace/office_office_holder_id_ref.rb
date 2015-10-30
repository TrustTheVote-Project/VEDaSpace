module Vedaspace::OfficeOfficeHolderIdRef
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    define_text_node(:office_holder_id_ref)
  end
  

end