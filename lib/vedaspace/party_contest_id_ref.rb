module Vedaspace::PartyContestIdRef
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    define_text_node(:contest_id_ref)
  end  

end