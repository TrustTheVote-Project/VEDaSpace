module Vedaspace::ElectionAdministrationOfficialIdRef
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    self.node_name = 'ElectionAdministrationOfficialIdRef'
    
    define_text_node(:election_official_id_ref)
  end
  
end