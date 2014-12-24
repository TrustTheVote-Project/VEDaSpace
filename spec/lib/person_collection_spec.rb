# <xsd:complexType name="PersonCollection">
#   <xsd:sequence>
#     <xsd:element name="Person" type="Person" minOccurs="1" maxOccurs="unbounded"/>
#   </xsd:sequence>
# </xsd:complexType>

require_relative '../spec_helper.rb'

describe VSSC::PersonCollection do
  let(:c) { VSSC::PersonCollection.new }
  before(:each) do
    c.person << VSSC::Person.new
  end
  it { should have_element_array("Person") }
  it { should validate_element_array_type("Person", VSSC::Person.new )}
  it { should validate_element_array_min_size("Person", 1)}
  
end
