module Vedaspace::ElectionAdministrationOfficialIdRef
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions  
  
  included do
    define_text_node(:election_official_id_ref)
  end
  
end