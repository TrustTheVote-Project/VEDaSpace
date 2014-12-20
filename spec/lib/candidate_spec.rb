# <xsd:complexType name="Candidate">
#   <xsd:sequence>
#     <xsd:element name="Party" type="xsd:IDREF" minOccurs="0"/>
#     <xsd:element name="Person" type="xsd:IDREF" minOccurs="0"/>
#     <xsd:element name="Office" type="xsd:IDREF" minOccurs="0" maxOccurs="unbounded"/>
#   </xsd:sequence>
#   <xsd:attribute name="object_id" type="xsd:ID" use="required"/>
#   <xsd:attribute name="ballotName" type="xsd:string" use="required"/>
#   <xsd:attribute name="candidateID" type="xsd:string"/>
#   <xsd:attribute name="fileDate" type="xsd:dateTime"/>
#   <xsd:attribute name="isIncumbent" type="xsd:boolean"/>
#   <xsd:attribute name="isTopTicket" type="xsd:boolean"/>
#   <xsd:attribute name="sequenceOrder" type="xsd:integer"/>
#   <xsd:attribute name="status" type="CandidateStatus"/>
# </xsd:complexType>

require_relative '../spec_helper.rb'


describe VSSC::Candidate do
  let(:c) { VSSC::Candidate.new }
  before(:each) do
    c.object_id = "abc"
    c.ballot_name = "abc"
  end
  subject { c }
  it { should have_element("Party") }
  it { should have_element("Person") }
  it { should have_element_array("Office") }
  
  it { should have_attribute("object_id") }
  it { should validate_presence_of_attribute("object_id") }
  
  it { should have_attribute("ballotName") }
  it { should validate_presence_of_attribute("ballotName") }

  it { should have_attribute("candidateID") }

  it { should have_attribute("fileDate") }
  it { should validate_attribute_type("fileDate", DateTime.now.iso8601)}
  
  it { should have_attribute("isIncumbent") }
  it { should validate_attribute_type("isIncumbent", true)}
  
  it { should have_attribute("isTopTicket") }
  it { should validate_attribute_type("isTopTicket", true)}
  
  it { should have_attribute("sequenceOrder") }
  it { should validate_attribute_type("sequenceOrder", 1)}
  
  it { should have_attribute("candidateStatus") }
  it { should validate_attribute_type("candidateStatus", VSSC::CandidateStatus.qualified)}
  
end