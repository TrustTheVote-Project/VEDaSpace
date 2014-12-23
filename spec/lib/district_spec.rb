#
# <xsd:complexType name="District">
#   <xsd:complexContent>
#     <xsd:extension base="GPUnit">
#       <xsd:attribute name="districtType" type="DistrictType" use="required"/>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>



require_relative '../spec_helper.rb'

describe VSSC::District do
  let(:d) { VSSC::District.new }
  before(:each) do
    d.district_type = VSSC::DistrictType.local
  end
  subject { d }
  it "should be a kind of GPUnit" do
    expect(d).to be_a(VSSC::GPUnit)
  end
  
  it { should have_attribute("districtType") }
  it { should validate_attribute_type("districtType", VSSC::DistrictType.congressional) }
  it { should validate_presence_of_attribute("districtType") }
  
end