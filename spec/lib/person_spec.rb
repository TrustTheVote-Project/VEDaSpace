# <xsd:complexType name="Person">
#   <xsd:sequence>
#     <xsd:element name="Party" type="xsd:IDREF" minOccurs="0"/>
#     <xsd:element name="Contact" type="Contact" minOccurs="0" maxOccurs="unbounded"/>
#   </xsd:sequence>
#   <xsd:attribute name="object_id" type="xsd:ID" use="required"/>
#   <xsd:attribute name="ethnicity" type="EthnicityType"/>
#   <xsd:attribute name="firstName" type="xsd:string"/>
#   <xsd:attribute name="gender" type="GenderType"/>
#   <xsd:attribute name="lastName" type="xsd:string" use="required"/>
#   <xsd:attribute name="middleName" type="xsd:string"/>
#   <xsd:attribute name="nickname" type="xsd:string"/>
#   <xsd:attribute name="prefix" type="xsd:string"/>
#   <xsd:attribute name="profession" type="xsd:string"/>
#   <xsd:attribute name="suffix" type="xsd:string"/>
#   <xsd:attribute name="title" type="xsd:string"/>
# </xsd:complexType>


require_relative '../spec_helper.rb'

describe VSSC::Person do
  let(:p) { VSSC::Person.new }
  before(:each) do
    p.object_id = "o_id"
    p.last_name = "last name"
  end
  subject { p }
  
  it { should have_element("Party") }
  it { should have_element_array("Contact") }
  it { should validate_element_array_type("Contact", VSSC::Contact.new) }
  
  it { should have_attribute("object_id") }
  it { should validate_presence_of_attribute("object_id") }
  it { should have_attribute("ethnicity") }
  it { should validate_attribute_type("ethnicity", VSSC::EthnicityType.asian) }
  it { should have_attribute("firstName") }
  it { should have_attribute("gender") }
  it { should validate_attribute_type("gender", VSSC::GenderType.female) }
  it { should have_attribute("lastName") }
  it { should validate_presence_of_attribute("lastName") }
  it { should have_attribute("middleName") }
  it { should have_attribute("nickname")}
  it { should have_attribute("prefix") }
  it { should have_attribute("profession") }
  it { should have_attribute("suffix") }
  it { should have_attribute("title") }
  
  
end