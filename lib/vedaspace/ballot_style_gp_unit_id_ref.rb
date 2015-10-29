module Vedasoace::BallotStyleGpUnitIdRef
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions  
  
  included do  
    define_text_node(:gp_unit_id_ref)
  end
end