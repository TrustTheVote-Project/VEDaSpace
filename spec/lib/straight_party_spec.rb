# <xsd:complexType name="StraightParty">
#   <xsd:complexContent>
#     <xsd:extension base="Contest"/>
#   </xsd:complexContent>
# </xsd:complexType>

require_relative '../spec_helper.rb'


describe VSSC::StraightParty do
  let(:s) { VSSC::StraightParty.new }
  it "should be a kind of Contest" do
    expect(s).to be_a(VSSC::Contest)
  end
  
end