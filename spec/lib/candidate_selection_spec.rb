# <xsd:complexType name="CandidateSelection">
#   <xsd:complexContent>
#     <xsd:extension base="BallotSelection">
#       <xsd:sequence>
#         <xsd:element name="Candidate" type="xsd:IDREF" maxOccurs="unbounded"/>
#         <xsd:element name="EndorsementParty" type="xsd:IDREF" minOccurs="0" maxOccurs="unbounded"/>
#       </xsd:sequence>
#       <xsd:attribute name="isWriteIn" type="xsd:boolean"/>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>


require_relative '../spec_helper.rb'


describe VSSC::CandidateSelection do
  let(:c) { VSSC::CandidateSelection.new }
  before(:each) do
    c.object_id = "abc"
  end
  subject { c }
  it "should be a kind of BallotSelection" do
    expect(c).to be_a(VSSC::BallotSelection)
  end
  it { should have_element_array("Candidate") }
  it { should have_element_array("EndorsementParty") }
  it { should have_attribute("isWriteIn") }
  it { should validate_attribute_type("isWriteIn", true) }
  
end