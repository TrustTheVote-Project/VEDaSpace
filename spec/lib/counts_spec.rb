# <xsd:complexType name="Counts" abstract="true">
#   <xsd:sequence>
#     <xsd:element name="GPUnit" type="xsd:IDREF" minOccurs="0"/>
#   </xsd:sequence>
#   <xsd:attribute name="object_id" type="xsd:ID" use="required"/>
#   <xsd:attribute name="ballotType" type="BallotType"/>
#   <xsd:attribute name="deviceManufacturer" type="xsd:string"/>
#   <xsd:attribute name="deviceModel" type="xsd:string"/>
#   <xsd:attribute name="deviceType" type="DeviceType"/>
# </xsd:complexType>


require_relative '../spec_helper.rb'


describe VSSC::Counts do
  let(:c) { VSSC::Counts.new }
  before(:each) do
    c.object_id = "abc"
  end
  subject { c }
  it { should have_element("GPUnit") }
  it { should have_attribute("object_id") }
  it { should validate_presence_of_attribute("object_id") }
  it { should have_attribute("ballotType") }
  it { should validate_attribute_type("ballotType", VSSC::BallotType.absentee) }
  
  it { should have_attribute("deviceManufacturer") }
  it { should have_attribute("deviceModel") }
  it { should have_attribute("deviceType") }
  it { should validate_attribute_type("deviceType", VSSC::DeviceType.electronic) }
end