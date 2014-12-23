# <xsd:complexType name="ContestCollection">
#   <xsd:sequence>
#     <xsd:element name="Contest" type="Contest" minOccurs="1" maxOccurs="unbounded"/>
#   </xsd:sequence>
# </xsd:complexType>
#

require_relative '../spec_helper.rb'

describe VSSC::ContestCollection do
  let(:c) { VSSC::ContestCollection.new }
  before(:each) do
    c.contest << VSSC::Contest.new
  end
  subject { c }
  it { should have_element_array("Contest") }
  it { should validate_element_array_type("Contest", VSSC::Contest.new )}
  it { should validate_element_array_min_size("Contest", 1)}
  
  
end