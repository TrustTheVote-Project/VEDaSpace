#
# <xsd:complexType name="Election">
#   <xsd:sequence>
#     <xsd:element name="BallotStyleCollection" type="BallotStyleCollection" minOccurs="0" maxOccurs="1"/>
#     <xsd:element name="CandidateCollection" type="CandidateCollection" minOccurs="0" maxOccurs="1"/>
#     <xsd:element name="ContestCollection" type="ContestCollection" minOccurs="0" maxOccurs="1"/>
#     <xsd:element name="ElectionGPScope" type="xsd:IDREF" minOccurs="0"/>
#   </xsd:sequence>
#   <xsd:attribute name="object_id" type="xsd:ID" use="required"/>
#   <xsd:attribute name="URL" type="xsd:anyURI"/>
#   <xsd:attribute name="absenteeCountStatus" type="BallotCountStatus"/>
#   <xsd:attribute name="date" type="xsd:date" use="required"/>
#   <xsd:attribute name="earlyCountStatus" type="BallotCountStatus"/>
#   <xsd:attribute name="electionDayCountStatus" type="BallotCountStatus"/>
#   <xsd:attribute name="name" type="xsd:string" use="required"/>
#   <xsd:attribute name="provisionalCountStatus" type="BallotCountStatus"/>
#   <xsd:attribute name="type" type="ElectionType" use="required"/>
#   <xsd:attribute name="writeInCountStatus" type="BallotCountStatus"/>
# </xsd:complexType>


require_relative '../spec_helper.rb'

describe VSSC::Election do
  let(:e) { VSSC::Election.new }
  before(:each) do
    e.object_id = "oid"
    e.name = "name"
    e.type = VSSC::ElectionType.general
    e.date = DateTime.now.iso8601
  end
  subject { e }
  
  it { should have_element("BallotStyleCollection") }
  it { should validate_element_type("BallotStyleCollection", VSSC::BallotStyleCollection.new) }
  it { should have_element("CandidateCollection") }
  it { should validate_element_type("CandidateCollection", VSSC::CandidateCollection.new) }
  it { should have_element("ElectionGPScope")}
  
  it { should have_attribute("object_id") }
  it { should validate_presence_of_attribute("object_id") }
  it { should have_attribute("name") }
  it { should validate_presence_of_attribute("name") }
  it { should have_attribute("type") }
  it { should validate_attribute_type("type", VSSC::ElectionType.general)}
  it { should validate_presence_of_attribute("type")}
  it { should have_attribute("date") }
  it { should validate_attribute_type("date", DateTime.new.iso8601)}
  it { should validate_presence_of_attribute("date")}
  it { should have_attribute("URL") }
  it { should have_attribute("absenteeCountStatus") }
  it { should validate_attribute_type("absenteeCountStatus", VSSC::BallotCountStatus.completed) }
  it { should have_attribute("earlyCountStatus") }
  it { should validate_attribute_type("earlyCountStatus", VSSC::BallotCountStatus.completed) }
  it { should have_attribute("electionDayCountStatus") }
  it { should validate_attribute_type("electionDayCountStatus", VSSC::BallotCountStatus.completed) }
  it { should have_attribute("provisionalCountStatus") }
  it { should validate_attribute_type("provisionalCountStatus", VSSC::BallotCountStatus.completed) }
  it { should have_attribute("writeInCountStatus") }
  it { should validate_attribute_type("writeInCountStatus", VSSC::BallotCountStatus.completed) }
  
  
  
end
