# <xsd:complexType name="Contact">
#   <xsd:attribute name="object_id" type="xsd:ID" use="required"/>
#   <xsd:attribute name="URL" type="xsd:anyURI"/>
#   <xsd:attribute name="addressNumber" type="xsd:string"/>
#   <xsd:attribute name="city" type="xsd:string"/>
#   <xsd:attribute name="country" type="xsd:string"/>
#   <xsd:attribute name="email" type="xsd:string"/>
#   <xsd:attribute name="fax" type="xsd:string"/>
#   <xsd:attribute name="hours" type="xsd:string"/>
#   <xsd:attribute name="name" type="xsd:string"/>
#   <xsd:attribute name="phone" type="xsd:string"/>
#   <xsd:attribute name="postalCode" type="xsd:string"/>
#   <xsd:attribute name="stateAbbreviation" type="xsd:string"/>
#   <xsd:attribute name="streetName" type="xsd:string"/>
# </xsd:complexType>


require_relative '../spec_helper.rb'


describe VSSC::Contact do
  let(:c) { VSSC::Contact.new }
  before(:each) do
    c.object_id = "abc"
  end
  subject { c }
  it { should have_attribute("object_id") }
  it { should validate_presence_of_attribute("object_id") }
  
  it { should have_attribute("URL") }
  it { should have_attribute("addressNumber") }
  it { should have_attribute("city") }
  it { should have_attribute("country") }
  it { should have_attribute("email") }
  it { should have_attribute("fax") }
  it { should have_attribute("hours") }
  it { should have_attribute("name") }
  it { should have_attribute("phone") }
  it { should have_attribute("postalCode") }
  it { should have_attribute("stateAbbreviation") }
  it { should have_attribute("streetName") }
end