# <xsd:complexType name="SpatialExtent">
#   <xsd:sequence>
#     <xsd:element name="Coordinates" type="xsd:string"/>
#   </xsd:sequence>
#   <xsd:attribute name="object_id" type="xsd:ID" use="required"/>
#   <xsd:attribute name="format" type="xsd:string" use="required"/>
# </xsd:complexType>

require_relative '../spec_helper.rb'


describe VSSC::SpatialExtent do
  let(:s) { VSSC::SpatialExtent.new }
  before(:each) do
    s.object_id = "oid"
    s.format = "format"
  end
  subject { s }
  it { should have_element("Coordinates") }
  it { should have_attribute("object_id")}
  it { should validate_presence_of_attribute("object_id") }
  it { should have_attribute("format")}
  it { should validate_presence_of_attribute("format") }
  
end