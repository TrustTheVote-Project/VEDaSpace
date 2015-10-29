# <xsd:complexType name="PartyRegistration">
#   <xsd:sequence>
#     <xsd:element name="Count" type="xsd:integer"/>
#     <xsd:element name="PartyId" type="xsd:IDREF"/>
#   </xsd:sequence>
# </xsd:complexType>
module Vedaspace::PartyRegistration
  extend ActiveSupport::Concern
  extend InclusionTracking
  include XsdFunctions
  
  included do
    define_element("Count", required: true, type: Fixnum)
    define_element("PartyId", method: :party_identifier)
  end
  
end
