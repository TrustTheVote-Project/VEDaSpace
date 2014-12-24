# <xsd:complexType name="GPUnitCollection">
#   <xsd:sequence>
#     <xsd:element name="GPUnit" type="GPUnit" minOccurs="1" maxOccurs="unbounded"/>
#   </xsd:sequence>
# </xsd:complexType>

require_relative '../spec_helper.rb'

describe VSSC::GPUnitCollection do
  let(:c) { VSSC::GPUnitCollection.new }
  before(:each) do
    c.gp_unit << VSSC::GPUnit.new
  end
  subject { c }
  it { should have_element_array("GPUnit") }
  it { should validate_element_array_type("GPUnit", VSSC::GPUnit.new )}
  it { should validate_element_array_min_size("GPUnit", 1)}
  
  
end