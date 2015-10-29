module Vedaspace::PartyContestIdRef
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions
  
  included do
    define_text_node(:contest_id_ref)
  end  

end