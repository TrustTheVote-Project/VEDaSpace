#
# <xsd:complexType name="PartyCollection">
#   <xsd:sequence>
#     <xsd:element name="Party" type="Party" minOccurs="1" maxOccurs="unbounded"/>
#   </xsd:sequence>
# </xsd:complexType>

require_relative '../spec_helper.rb'

describe VSSC::PartyCollection do
  let(:c) { VSSC::PartyCollection.new }
  before(:each) do
    c.party << VSSC::Party.new
  end
  subject { c }
  it { should have_element_array("Party") }
  it { should validate_element_array_type("Party", VSSC::Party.new )}
  it { should validate_element_array_min_size("Party", 1)}
  
  
end