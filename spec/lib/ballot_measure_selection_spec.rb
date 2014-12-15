# <xsd:complexType name="BallotMeasureSelection">
#   <xsd:complexContent>
#     <xsd:extension base="BallotSelection">
#       <xsd:attribute name="selection" type="xsd:string" use="required"/>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>

require_relative '../spec_helper.rb'

describe VSSC::BallotMeasureSelection do
  let(:b) { VSSC::BallotMeasureSelection.new }
  before(:each) do
    b.object_id = "abc"
  end
  
  it "should be a kind of BallotSelection" do
    expect(b).to be_a(VSSC::BallotSelection)
  end
  
  it "should have a selection string attribute" do
    expect(b).to have_attribute("selection")
  end
  
  it "should require the attribute 'selection'" do
    expect(b).to_not be_valid
    b.selection = "abc"
    expect(b).to be_valid
  end
  
end
    