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
  let(:b) { VSSC::BallotMeasure.new }
  
  it "should be a kind of Contest" do
    expect(b).to be_a(VSSC::Contest)
  end
  
  it "should have a FullText string property" do
    expect(b).to have_element("FullText")
  end
  
  it "should have a SummaryText string property" do
    expect(b).to have_element("SummaryText")
  end
    
end