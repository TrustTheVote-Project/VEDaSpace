# <xsd:complexType name="Contest" abstract="true">
#   <xsd:sequence>
#     <xsd:element name="BallotSelection" type="BallotSelection" minOccurs="0" maxOccurs="unbounded"/>
#     <xsd:element name="ContestGPScope" type="xsd:IDREF" minOccurs="0"/>
#     <xsd:element name="ContestTotalCounts" type="TotalCounts" minOccurs="0" maxOccurs="unbounded"/>
#     <xsd:element name="ContestTotalCountsByGPUnit" type="TotalCounts" minOccurs="0" maxOccurs="unbounded"/>
#   </xsd:sequence>
#   <xsd:attribute name="object_id" type="xsd:ID" use="required"/>
#   <xsd:attribute name="abbreviation" type="xsd:string"/>
#   <xsd:attribute name="localContestCode" type="xsd:string"/>
#   <xsd:attribute name="name" type="xsd:string" use="required"/>
#   <xsd:attribute name="nationalContestCode" type="xsd:string"/>
#   <xsd:attribute name="reportedPrecincts" type="xsd:integer"/>
#   <xsd:attribute name="sequenceOrder" type="xsd:integer"/>
#   <xsd:attribute name="stateContestCode" type="xsd:string"/>
#   <xsd:attribute name="totalPrecincts" type="xsd:integer"/>
#   <xsd:attribute name="voteVariation" type="VoteVariation"/>
# </xsd:complexType>


require_relative '../spec_helper.rb'


describe VSSC::Contest do
  let(:c) { VSSC::Contest.new }
  before(:each) do
    c.object_id = "abc"
    c.name = "name"
  end
  subject { c }
  
  it { should have_element_array("BallotSelection") }
  it { should validate_element_array_type("BallotSelection", VSSC::BallotSelection.new)}
  
  it { should have_element("ContestGPScope") }

  it { should have_element_array("ContestTotalCounts") }
  it { should validate_element_array_type("ContestTotalCounts", VSSC::TotalCounts.new)}

  it { should have_element_array("ContestTotalCountsByGPUnit") }
  it { should validate_element_array_type("ContestTotalCountsByGPUnit", VSSC::TotalCounts.new)}
  
  it { should have_attribute("object_id") }
  it { should validate_presence_of_attribute("object_id") }
  
  it { should have_attribute("abbreviation") }
  it { should have_attribute("localContestCode") }
  it { should have_attribute("name") }
  it { should validate_presence_of_attribute("name") }
  it { should have_attribute("nationalContestCode") }
  it { should have_attribute("reportedPrecincts") }
  it { should validate_attribute_type("reportedPrecincts", 1) }
  it { should have_attribute("sequenceOrder") }
  it { should validate_attribute_type("sequenceOrder", 1) }
  it { should have_attribute("stateContestCode") }
  it { should have_attribute("totalPrecincts") }
  it { should validate_attribute_type("totalPrecincts", 1)}
  it { should have_attribute("voteVariation")}
  it { should validate_attribute_type("voteVariation", VSSC::VoteVariation.approval)}
  
end