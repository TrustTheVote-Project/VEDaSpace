# <xsd:complexType name="VoteCounts">
#   <xsd:complexContent>
#     <xsd:extension base="Counts">
#       <xsd:attribute name="count" type="xsd:float" use="required"/>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>


describe VSSC::VoteCounts do
  let(:c) { VSSC::VoteCounts.new }
  before(:each) do
    c.object_id = "oid"
  end
  it "should be a kind of Counts" do
    expect(c).to be_a(VSSC::Counts)
  end
  subject { c }
  it { should have_attribute("count") }
  it { should validate_attribute_type("count", 1.123 )}
  
end