# <xsd:complexType name="CandidateCollection">
#   <xsd:sequence>
#     <xsd:element name="Candidate" type="Candidate" minOccurs="1" maxOccurs="unbounded"/>
#   </xsd:sequence>
# </xsd:complexType>

require_relative '../spec_helper.rb'

describe VSSC::CandidateCollection do
  let(:c) { VSSC::CandidateCollection.new }
  before(:each) do
    c.candidate << VSSC::Candidate.new
  end
  subject { c }
  it { should have_element_array("Candidate") }
  it { should validate_element_array_type("Candidate", VSSC::Candidate.new )}
  it { should validate_element_array_min_size("Candidate", 1)}
  
  
end