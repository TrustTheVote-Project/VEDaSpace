module Vedaspace
  module Election
    extend ActiveSupport::Concern
    extend InclusionTracking
    include XsdFunctions  
    
    included do
      define_element("BallotStyleCollection", typew: Vedaspace::BallotStyle, method: :ballot_styles, passthrough: "BallotStyle")
      
    #   define_element("CandidateCollection", type: Vssc::Candidate, method: :candidates, passthrough: "Candidate")
    #   has_many :candidates, dependent: :destroy
    #
    #   define_element("ContactInformation", type: Vssc::ContactInformation, belongs_to: true)
    #
    #   define_element("ContestCollection", type: Vssc::Contest, method: :contests, passthrough: "Contest")
    #   has_many :contests, dependent: :destroy
    #
    #   define_element("CountStatus", type: Vssc::CountStatus, method: :count_statuses)
    #   has_many :count_statuses, as: :count_statusable
    #
    #   define_element("ElectionScopeId", method: :election_scope_identifier)
    #
    #   define_element("ExternalIdentifiers", type: Vssc::ExternalIdentifierCollection, method: :external_identifier_collection)
    #   has_one :external_identifier_collection, :as=>:identifiable
    #
    #   define_element("Name", type: Vssc::InternationalizedText, belongs_to: true)
    #
    #
    #   define_element("StartDate", type: Date)
    #   define_element("EndDate", type: Date)
    #   define_element("Type", type: Vssc::Enum::ElectionType, method: "election_type")
    end

  end
end