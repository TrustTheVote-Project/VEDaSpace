# <xsd:complexType name="OfficeCollection">
#   <xsd:sequence>
#     <xsd:element name="Office" type="Office" minOccurs="1" maxOccurs="unbounded"/>
#   </xsd:sequence>
# </xsd:complexType>

require_relative '../spec_helper.rb'

describe VSSC::OfficeCollection do
  let(:c) { VSSC::OfficeCollection.new }
  before(:each) do
    c.office << VSSC::Office.new
  end
  subject { c }
  it { should have_element_array("Office") }
  it { should validate_element_array_type("Office", VSSC::Office.new )}
  it { should validate_element_array_min_size("Office", 1)}
  
  
end