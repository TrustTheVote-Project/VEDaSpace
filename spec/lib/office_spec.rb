# <xsd:complexType name="Office">
#   <xsd:sequence>
#     <xsd:element name="OfficeGPScope" type="xsd:IDREF" minOccurs="0"/>
#   </xsd:sequence>
#   <xsd:attribute name="object_id" type="xsd:ID" use="required"/>
#   <xsd:attribute name="filingDate" type="xsd:dateTime"/>
#   <xsd:attribute name="incumbentRunning" type="xsd:boolean"/>
#   <xsd:attribute name="localOfficeCode" type="xsd:string"/>
#   <xsd:attribute name="name" type="xsd:string" use="required"/>
#   <xsd:attribute name="nationalOfficeCode" type="xsd:string"/>
#   <xsd:attribute name="partisan" type="xsd:boolean"/>
#   <xsd:attribute name="stateOfficeCode" type="xsd:string"/>
#   <xsd:attribute name="termEndDate" type="xsd:date"/>
#   <xsd:attribute name="termStartDate" type="xsd:date"/>
#   <xsd:attribute name="unexpiredTerm" type="xsd:boolean"/>
# </xsd:complexType>



require_relative '../spec_helper.rb'


describe VSSC::Office do
  let(:o) { VSSC::Office.new }
  before(:each) do
    o.object_id = "oid"
    o.name = "office name"
  end
  subject { o }

  it { should have_element("OfficeGPScope") }
  
  it { should have_attribute("object_id") }
  it { should validate_presence_of_attribute("object_id") }
  it { should have_attribute("name") }
  it { should validate_presence_of_attribute("name")}
  it { should have_attribute("filingDate") }
  it { should validate_attribute_type("filingDate", DateTime.now.iso8601)}
  it { should have_attribute("incumbentRunning") }
  it { should validate_attribute_type("incumbentRunning", false) }
  it { should have_attribute("localOfficeCode") }
  it { should have_attribute("nationalOfficeCode") }
  it { should have_attribute("stateOfficeCode")}
  it { should have_attribute("partisan") }
  it { should validate_attribute_type("partisan", true)}
  it { should have_attribute("termStartDate") }
  it { should validate_attribute_type("termStartDate", DateTime.now.iso8601) }
  it { should have_attribute("termEndDate") }
  it { should validate_attribute_type("termEndDate", DateTime.now.iso8601) }
  it { should have_attribute("unexpiredTerm") }
  it { should validate_attribute_type("unexpiredTerm", false) }
  
end