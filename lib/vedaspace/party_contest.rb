# <xsd:complexType name="PartyContest">
#   <xsd:complexContent>
#     <xsd:extension base="Contest"/>
#   </xsd:complexContent>
# </xsd:complexType>
module Vedaspace::PartyContest
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    include Vedaspace::Contest
    self.node_name = 'PartyContest'
    
  end
end
