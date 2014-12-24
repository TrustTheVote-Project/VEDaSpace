# <xsd:complexType name="OrderedContest">
#   <xsd:sequence>
#     <xsd:element name="Contest" type="xsd:IDREF"/>
#     <xsd:element name="BallotSelection" type="xsd:IDREF" minOccurs="0" maxOccurs="unbounded"/>
#   </xsd:sequence>
#   <xsd:attribute name="object_id" type="xsd:ID" use="required"/>
# </xsd:complexType>


require_relative '../spec_helper.rb'


describe VSSC::OrderedContest do
  let(:o) { VSSC::OrderedContest.new }
  before(:each) do
    o.object_id = "oid"
  end
  subject { o }
  it { should have_element("Contest") }
  it { should have_element_array("BallotSelection") }
  it { should have_attribute("object_id")}
  it { should validate_presence_of_attribute("object_id") }
end