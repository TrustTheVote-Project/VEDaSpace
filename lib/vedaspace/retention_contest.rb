module Vedaspace::RetentionContest
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    include Vedaspace::BallotMeasureContest
    self.node_name = 'RetentionContest'
    
    define_element("CandidateId", method: :candidate_identifier)
    define_element("OfficeId", method: :office_identifier)
  end
  
end