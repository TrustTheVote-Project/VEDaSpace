module Vedaspace::OfficeGroupOfficeIdRef
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions
  
  included do
    define_text_node(:office_id_ref)
  end

end