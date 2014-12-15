# <xsd:complexType name="BallotSelection" abstract="true">
#   <xsd:sequence>
#     <xsd:element name="VoteCounts" type="VoteCounts" minOccurs="0" maxOccurs="unbounded"/>
#   </xsd:sequence>
#   <xsd:attribute name="object_id" type="xsd:ID" use="required"/>
#   <xsd:attribute name="ballotSelectionID" type="xsd:string"/>
# </xsd:complexType>

require_relative '../spec_helper.rb'

describe VSSC::BallotSelection do
  let(:b) { VSSC::BallotSelection.new }
  before(:each) do
    b.object_id = "abc"
  end
  
  subject { b }
  
  it { should have_element("VoteCounts") }
  it { should have_element_array("VoteCounts") }
  it { should validate_element_array_type("VoteCounts", VSSC::VoteCounts.new) }
  it { should have_attribute("object_id") }
  it { should validate_presence_of_attribute("object_id") }
  it { should have_attribute("ballotSelectionID") }





end