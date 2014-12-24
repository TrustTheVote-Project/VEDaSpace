# <xsd:complexType name="PartyRegistration">
#   <xsd:sequence>
#     <xsd:element name="Party" type="xsd:IDREF"/>
#   </xsd:sequence>
#   <xsd:attribute name="object_id" type="xsd:ID" use="required"/>
#   <xsd:attribute name="count" type="xsd:integer" use="required"/>
# </xsd:complexType>


require_relative '../spec_helper.rb'


describe VSSC::PartyRegistration do
  let(:p) { VSSC::PartyRegistration.new }
  before(:each) do
    p.object_id = "oid"
    p.count = 4
  end
  subject { p }
  it { should have_element("Party") }
  it { should have_attribute("object_id") }
  it { should validate_presence_of_attribute("object_id") }
  it { should have_attribute("count")}
  it { should validate_presence_of_attribute("count")}
  it { should validate_attribute_type("count", 2)}
end