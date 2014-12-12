# <xsd:complexType name="BallotMeasure">
#   <xsd:complexContent>
#     <xsd:extension base="Contest">
#       <xsd:sequence>
#         <xsd:element name="FullText" type="xsd:string" minOccurs="0"/>
#         <xsd:element name="SummaryText" type="xsd:string" minOccurs="0"/>
#       </xsd:sequence>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>

require_relative '../spec_helper.rb'

describe VSSC::BallotMeasure do
  it "should be a kind of Contest" do
    expect(VSSC::BallotMeasure.new).to be_a(VSSC::Contest)
  end
  it "should have a FullText string property" do
    b = VSSC::BallotMeasure.new
    expect(b).to respond_to(:full_text=)
    expect(b).to respond_to(:full_text)
    expect(b.elements["FullText"]).to  eq(:full_text)
  end
  it "should have a SummaryText string property"
end