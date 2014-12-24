# <xsd:complexType name="TotalCounts">
#   <xsd:complexContent>
#     <xsd:extension base="Counts">
#       <xsd:attribute name="ballotsCast" type="xsd:integer"/>
#       <xsd:attribute name="overvotes" type="xsd:integer"/>
#       <xsd:attribute name="undervotes" type="xsd:integer"/>
#       <xsd:attribute name="writeIns" type="xsd:integer"/>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>


describe VSSC::TotalCounts do
  let(:c) { VSSC::TotalCounts.new }
  before(:each) do
    c.object_id = "oid"
  end
  it "should be a kind of Counts" do
    expect(c).to be_a(VSSC::Counts)
  end
  subject { c }
  it { should have_attribute("ballotsCast") }
  it { should validate_attribute_type("ballotsCast", 11 )}
  it { should have_attribute("overvotes") }
  it { should validate_attribute_type("overvotes", 11 )}
  it { should have_attribute("undervotes") }
  it { should validate_attribute_type("undervotes", 11 )}
  it { should have_attribute("writeIns") }
  it { should validate_attribute_type("writeIns", 11 )}
  
end