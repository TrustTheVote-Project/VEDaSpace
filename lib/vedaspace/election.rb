module Vedaspace::Election
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions  
  
  included do
    define_element("BallotStyleCollection", typew: Vedaspace::BallotStyle, method: :ballot_styles, passthrough: "BallotStyle")
    
    define_element("CandidateCollection", type: Vedaspace::Candidate, method: :candidates, passthrough: "Candidate")

    define_element("ContactInformation", type: Vedaspace::ContactInformation, belongs_to: true)

    define_element("ContestCollection", type: Vedaspace::Contest, method: :contests, passthrough: "Contest")

    define_element("CountStatus", type: Vedaspace::CountStatus, method: :count_statuses)

    define_element("ElectionScopeId", method: :election_scope_identifier)
  
    define_element("ExternalIdentifiers", type: Vedaspace::ExternalIdentifierCollection, method: :external_identifier_collection)

    define_element("Name", type: Vedaspace::InternationalizedText, belongs_to: true)

    define_element("StartDate", type: Date)
    define_element("EndDate", type: Date)
    define_element("Type", type: Vedaspace::Enum::ElectionType, method: "election_type")
  end
end