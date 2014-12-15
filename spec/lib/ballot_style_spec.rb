#
# <xsd:complexType name="BallotStyle">
#   <xsd:sequence>
#     <xsd:element name="OrderedContest" type="OrderedContest" minOccurs="0" maxOccurs="unbounded"/>
#     <xsd:element name="GPUnit" type="xsd:IDREF"/>
#   </xsd:sequence>
#   <xsd:attribute name="object_id" type="xsd:ID" use="required"/>
#   <xsd:attribute name="ballotStyleID" type="xsd:string"/>
# </xsd:complexType>

require_relative '../spec_helper.rb'


describe VSSC::BallotStyle do
  let(:b) { VSSC::BallotStyle.new }
  before(:each) do
    b.object_id="abc"
  end
  subject { b }
  it { should have_element("OrderedContest") }
  it { should have_element_array("OrderedContest") }
  it { should validate_element_array_type("OrderedContest", VSSC::OrderedContest.new) }
  it { should have_element("GPUnit") }
  it { should have_attribute("object_id") }
  it { should validate_presence_of_attribute("object_id") }
  it { should have_attribute("ballotStyleID")}
  
  
end