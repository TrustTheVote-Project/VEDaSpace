module Vedaspace
  module BallotStyle
    extend ActiveSupport::Concern
    extend InclusionTracking
    include XsdFunctions  
    
    included do
  
      define_element("ExternalIdentifiers", type: Vedastore::ExternalIdentifierCollection, method: :external_identifier_collection)
      
      define_element("OrderedContest", method: :ordered_contests, type: Vedastore::OrderedContest)
      
      define_element("GpUnitId", type: Vedastore::BallotStyleGpUnitIdRef, method: :ballot_style_gp_unit_id_refs)
      
      define_element("ImageUri")

      define_element("PartyId", type: Vedastore::BallotStylePartyIdRef, method: :ballot_style_party_id_refs)

      define_attribute("objectId")
    end
  end
end