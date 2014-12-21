# <xsd:complexType name="CandidateChoice">
#   <xsd:complexContent>
#     <xsd:extension base="Contest">
#       <xsd:sequence>
#         <xsd:element name="Office" type="xsd:IDREF" minOccurs="0"/>
#         <xsd:element name="PrimaryParty" type="xsd:IDREF" minOccurs="0"/>
#       </xsd:sequence>
#       <xsd:attribute name="numberElected" type="xsd:integer"/>
#       <xsd:attribute name="votesAllowed" type="xsd:integer" use="required"/>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>


require_relative '../spec_helper.rb'


describe VSSC::CandidateChoice do
  let(:c) { VSSC::CandidateChoice.new }
  before(:each) do
    c.votes_allowed = 1
    c.name = "abc"
    c.object_id= "123"
  end
  subject { c }
  it "should be a kind of Contest" do
    expect(c).to be_a(VSSC::Contest)
  end
  it { should have_element("Office") }
  it { should have_element("PrimaryParty") }
  it { should have_attribute("numberElected") }
  it { should validate_attribute_type("numberElected", 2)}
  it { should have_attribute("votesAllowed") }
  it { should validate_presence_of_attribute("votesAllowed") }
  it { should validate_attribute_type("votesAllowed", 2)}
end
