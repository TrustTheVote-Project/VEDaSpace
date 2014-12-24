# <xsd:complexType name="GPUnit" abstract="true">
#   <xsd:sequence>
#     <xsd:element name="GPSubUnit" type="GPUnit" minOccurs="0" maxOccurs="unbounded"/>
#     <xsd:element name="GPSubUnitRef" type="xsd:IDREF" minOccurs="0" maxOccurs="unbounded"/>
#     <xsd:element name="GPUnitTotalCounts" type="TotalCounts" minOccurs="0" maxOccurs="unbounded"/>
#     <xsd:element name="PartyRegistration" type="PartyRegistration" minOccurs="0"/>
#     <xsd:element name="SpatialDimension" type="SpatialDimension" minOccurs="0" maxOccurs="unbounded"/>
#   </xsd:sequence>
#   <xsd:attribute name="object_id" type="xsd:ID" use="required"/>
#   <xsd:attribute name="URL" type="xsd:anyURI"/>
#   <xsd:attribute name="localGeoCode" type="xsd:string"/>
#   <xsd:attribute name="name" type="xsd:string"/>
#   <xsd:attribute name="nationalGeoCode" type="xsd:string"/>
#   <xsd:attribute name="stateGeoCode" type="xsd:string"/>
# </xsd:complexType>




require_relative '../spec_helper.rb'

describe VSSC::GPUnit do
  let(:g) { VSSC::GPUnit.new }
  before(:each) do
    g.object_id = "oid"  
  end
  subject { g }
  
  it { should have_element_array("GPSubUnit") }
  it { should validate_element_array_type("GPSubUnit", VSSC::GPUnit.new)}
  it { should have_element_array("GPSubUnitRef") }
  it { should have_element_array("GPUnitTotalCounts") }
  it { should validate_element_array_type("GPUnitTotalCounts", VSSC::TotalCounts.new) }
  it { should have_element("PartyRegistration") }
  it { should validate_element_type("PartyRegistration", VSSC::PartyRegistration.new) }
  it { should have_element_array("SpatialDimension") }
  it { should validate_element_array_type("SpatialDimension", VSSC::SpatialDimension.new) }
  
  it { should have_attribute("object_id") }
  it { should validate_presence_of_attribute("object_id") }
  it { should have_attribute("URL") }
  it { should have_attribute("localGeoCode") }
  it { should have_attribute("name") }
  it { should have_attribute("nationalGeoCode") }
  it { should have_attribute("stateGeoCode") }
  
  
end