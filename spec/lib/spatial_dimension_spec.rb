# <xsd:complexType name="SpatialDimension">
#   <xsd:sequence>
#     <xsd:element name="SpatialExtent" type="SpatialExtent" minOccurs="0"/>
#   </xsd:sequence>
#   <xsd:attribute name="object_id" type="xsd:ID" use="required"/>
#   <xsd:attribute name="map" type="xsd:anyURI"/>
# </xsd:complexType>


require_relative '../spec_helper.rb'


describe VSSC::SpatialDimension do
  let(:s) { VSSC::SpatialDimension.new }
  before(:each) do
    s.object_id = "oid"
    
  end
  subject { s }
  it { should have_element("SpatialExtent") }
  it { should validate_element_type("SpatialExtent", VSSC::SpatialExtent.new)}
  it { should have_attribute("object_id")}
  it { should validate_presence_of_attribute("object_id") }
  it { should have_attribute("map")}
end