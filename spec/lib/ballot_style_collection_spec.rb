# <xsd:complexType name="BallotStyleCollection">
#   <xsd:sequence>
#     <xsd:element name="BallotStyle" type="BallotStyle" minOccurs="1" maxOccurs="unbounded"/>
#   </xsd:sequence>
# </xsd:complexType>

require_relative '../spec_helper.rb'

describe VSSC::BallotStyleCollection do
  let(:b) { VSSC::BallotStyleCollection.new }
  before(:each) do
    b.ballot_style << VSSC::BallotStyle.new
  end
  subject { b }
  it { should have_element_array("BallotStyle") }
  it { should validate_element_array_type("BallotStyle", VSSC::BallotStyle.new )}
  it { should validate_element_array_min_size("BallotStyle", 1)}
  
  
end