#
# <xsd:complexType name="Party">
#   <xsd:complexContent>
#     <xsd:extension base="BallotSelection">
#       <xsd:attribute name="abbreviation" type="xsd:string"/>
#       <xsd:attribute name="localPartyCode" type="xsd:string"/>
#       <xsd:attribute name="name" type="xsd:string"/>
#       <xsd:attribute name="nationalPartyCode" type="xsd:string"/>
#       <xsd:attribute name="statePartyCode" type="xsd:string"/>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>


require_relative '../spec_helper.rb'


describe VSSC::Party do
  let(:c) { VSSC::Party.new }
  subject { c }
  it "should be a kind of BallotSelection" do
    expect(c).to be_a(VSSC::BallotSelection)
  end
  it { should have_attribute("abbreviation") }
  it { should have_attribute("localPartyCode") }
  it { should have_attribute("name") }
  it { should have_attribute("nationalPartyCode") }
  it { should have_attribute("statePartyCode") }
  
end