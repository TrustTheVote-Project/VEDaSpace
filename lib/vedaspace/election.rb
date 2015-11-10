module Vedaspace::Election
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    self.node_name = 'Election'
    
    define_element("BallotStyleCollection", type: Vedaspace::BallotStyle, method: :ballot_styles, passthrough: "BallotStyle", multiple: true)
    
    define_element("CandidateCollection", type: Vedaspace::Candidate, method: :candidates, passthrough: "Candidate", multiple: true)

    define_element("ContactInformation", type: Vedaspace::ContactInformation, belongs_to: true)

    define_element("ContestCollection", type: Vedaspace::Contest, method: :contests, passthrough: "Contest", multiple: true)

    define_element("CountStatus", type: Vedaspace::CountStatus, method: :count_statuses, multiple: true)

    define_element("ElectionScopeId", method: :election_scope_identifier)
  
    define_element("ExternalIdentifiers", type: Vedaspace::ExternalIdentifierCollection, method: :external_identifier_collection)

    define_element("Name", type: Vedaspace::InternationalizedText, belongs_to: true)

    define_element("StartDate", type: Date)
    define_element("EndDate", type: Date)
    define_element("Type", type: Vedaspace::Enum::ElectionType, method: "election_type")
  end
end