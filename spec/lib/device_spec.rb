# <xsd:complexType name="Device">
#   <xsd:complexContent>
#     <xsd:extension base="GPUnit">
#       <xsd:attribute name="deviceType" type="DeviceType" use="required"/>
#       <xsd:attribute name="manufacturer" type="xsd:string"/>
#       <xsd:attribute name="serialNumber" type="xsd:string"/>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>



require_relative '../spec_helper.rb'


describe VSSC::Device do
  let(:d) { VSSC::Device.new }
  before(:each) do
    d.device_type = VSSC::DeviceType.lever
    d.object_id = "oid"
  end
  subject { d }
  it "should be a kind of GPUnit" do
    expect(d).to be_a(VSSC::GPUnit)
  end
  
  it { should have_attribute("deviceType") }
  it { should validate_attribute_type("deviceType", VSSC::DeviceType.electronic) }
  it { should validate_presence_of_attribute("deviceType") }
  it { should have_attribute("manufacturer") }
  it { should have_attribute("serialNumber") }
  
end