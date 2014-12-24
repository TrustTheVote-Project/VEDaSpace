# <xsd:complexType name="ReportingUnit">
#   <xsd:complexContent>
#     <xsd:extension base="GPUnit">
#       <xsd:sequence>
#         <xsd:element name="Authority" type="xsd:IDREF" minOccurs="0" maxOccurs="unbounded"/>
#         <xsd:element name="ReportingUnitContact" type="Contact" minOccurs="0" maxOccurs="unbounded"/>
#       </xsd:sequence>
#       <xsd:attribute name="hasReported" type="xsd:boolean"/>
#       <xsd:attribute name="registeredVoters" type="xsd:integer"/>
#       <xsd:attribute name="reportedPrecincts" type="xsd:integer"/>
#       <xsd:attribute name="reportingUnitType" type="ReportingUnitType" use="required"/>
#       <xsd:attribute name="totalParticipatingVoters" type="xsd:integer"/>
#       <xsd:attribute name="totalPrecincts" type="xsd:integer"/>
#     </xsd:extension>
#   </xsd:complexContent>
# </xsd:complexType>


require_relative '../spec_helper.rb'


describe VSSC::ReportingUnit do
  let(:r) { VSSC::ReportingUnit.new }
  before(:each) do
    r.object_id = "oid"
    r.reporting_unit_type = VSSC::ReportingUnitType.city
  end
  subject { r }
  it "should be a kind of GPUnit" do
    expect(r).to be_a(VSSC::GPUnit)
  end
  
  it { should have_element_array("Authority") }
  it { should have_element_array("ReportingUnitContact")}
  it { should validate_element_array_type("ReportingUnitContact", VSSC::Contact.new )}
  
  it { should have_attribute("hasReported")}
  it { should validate_attribute_type("hasReported", true)}
  it { should have_attribute("registeredVoters")}
  it { should validate_attribute_type("registeredVoters", 10)}
  it { should have_attribute("reportedPrecincts")}
  it { should validate_attribute_type("reportedPrecincts", 10)}
  it { should have_attribute("totalParticipatingVoters")}
  it { should validate_attribute_type("totalParticipatingVoters", 10)}
  it { should have_attribute("totalPrecincts")}
  it { should validate_attribute_type("totalPrecincts", 10)}
  it { should have_attribute("reportingUnitType") }
  it { should validate_attribute_type("reportingUnitType", VSSC::ReportingUnitType.city) }
  it { should validate_presence_of_attribute("reportingUnitType")}

end