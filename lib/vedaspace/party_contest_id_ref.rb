module Vedaspace::PartyContestIdRef
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    self.node_name = 'PartyContestIdRef'
    
    define_text_node(:contest_id_ref)
  end  

end