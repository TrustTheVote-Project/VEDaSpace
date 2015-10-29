class Vedaspace::RetentionContest
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions
  
  included do
    include Vedaspace::BallotMeasureContest
    define_element("CandidateId", method: :candidate_identifier)
    define_element("OfficeId", method: :office_identifier)
  end
  
end