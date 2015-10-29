# <xsd:complexType name="PartyContest">
#   <xsd:complexContent>
#     <xsd:extension base="Contest"/>
#   </xsd:complexContent>
# </xsd:complexType>
module Vedaspace::PartyContest
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions
  
  included do
    include Vedaspace::Contest
  end
end
