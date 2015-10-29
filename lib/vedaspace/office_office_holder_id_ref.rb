module Vedaspace::OfficeOfficeHolderIdRef
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions
  
  included do
    define_text_node(:office_holder_id_ref)
  end
  

end