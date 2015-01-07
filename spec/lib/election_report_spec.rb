#
# <xsd:complexType name="ElectionReport">
#   <xsd:sequence>
#     <xsd:element name="Message" type="xsd:string" minOccurs="0"/>
#     <xsd:element name="GPUnitCollection" type="GPUnitCollection" minOccurs="0" maxOccurs="1"/>
#     <xsd:element name="PartyCollection" type="PartyCollection" minOccurs="0" maxOccurs="1"/>
#     <xsd:element name="PersonCollection" type="PersonCollection" minOccurs="0" maxOccurs="1"/>
#     <xsd:element name="OfficeCollection" type="OfficeCollection" minOccurs="0" maxOccurs="1"/>
#     <xsd:element name="Election" type="Election" minOccurs="0" maxOccurs="unbounded"/>
#     <xsd:element ref="ds:Signature" minOccurs="0"/>
#   </xsd:sequence>
#   <xsd:attribute name="object_id" type="xsd:ID" use="required"/>
#   <xsd:attribute name="date" type="xsd:dateTime" use="required"/>
#   <xsd:attribute name="format" type="ReportFormat" use="required"/>
#   <xsd:attribute name="issuer" type="xsd:string" use="required"/>
#   <xsd:attribute name="sequence" type="xsd:integer" use="required"/>
#   <xsd:attribute name="sequenceEnd" type="xsd:integer" use="required"/>
#   <xsd:attribute name="stateAbbreviation" type="xsd:string" use="required"/>
#   <xsd:attribute name="stateCode" type="xsd:string"/>
#   <xsd:attribute name="status" type="ReportStatus" use="required"/>
#   <xsd:attribute name="vendorApplicationID" type="xsd:string" use="required"/>
# </xsd:complexType>



require_relative '../spec_helper.rb'

describe VSSC::ElectionReport do
  let(:e) { VSSC::ElectionReport.new }
  before(:each) do
    e.object_id = "oid"
    e.date = DateTime.now.iso8601
    e.format = VSSC::ReportFormat.precinct_level
    e.status = VSSC::ReportStatus.test
    e.issuer = "issuer"
    e.sequence = 1
    e.sequence_end = 5
    e.state_abbreviation = "ma"
    e.vendor_application_id = "ID"
  end
  subject { e }
  
  it { should have_element("Message") }
  it { should have_element("GPUnitCollection") }
  it { should validate_element_type("GPUnitCollection", VSSC::GPUnitCollection.new) }
  it { should have_element("PartyCollection") }
  it { should validate_element_type("PartyCollection", VSSC::PartyCollection.new) }
  it { should have_element("PersonCollection") }
  it { should validate_element_type("PersonCollection", VSSC::PersonCollection.new) }
  it { should have_element("OfficeCollection") }
  it { should validate_element_type("OfficeCollection", VSSC::OfficeCollection.new) }
  it { should have_element_array("Election") }
  it { should validate_element_array_type("Election", VSSC::Election.new) }

  it { should have_attribute("object_id") }
  it { should validate_presence_of_attribute("object_id") }
  it { should have_attribute("date") }
  it { should validate_presence_of_attribute("date") }
  it { should validate_attribute_type("date", DateTime.now.iso8601) }
  it { should have_attribute("format") }
  it { should validate_presence_of_attribute("format") }
  it { should validate_attribute_type("format", VSSC::ReportFormat.precinct_level) }
  it { should have_attribute("status") }
  it { should validate_presence_of_attribute("status") }
  it { should validate_attribute_type("status", VSSC::ReportStatus.test) }
  it { should have_attribute("issuer") }
  it { should validate_presence_of_attribute("issuer") }
  it { should have_attribute("sequence") }
  it { should validate_presence_of_attribute("sequence") }
  it { should validate_attribute_type("sequence", 1)}
  it { should have_attribute("sequenceEnd") }
  it { should validate_presence_of_attribute("sequenceEnd") }
  it { should validate_attribute_type("sequenceEnd", 1)}
  it { should have_attribute("stateAbbreviation") }
  it { should validate_presence_of_attribute("stateAbbreviation") }
  it { should have_attribute("stateCode") }
  it { should have_attribute("vendorApplicationID") }
  it { should validate_presence_of_attribute("vendorApplicationID") }
  
  
  describe 'XML import/export' do
    it "should import/export equivalent files" do
      #xml_file = './spec/fixtures/ohio2014-simplified.xml'
      xml_file = './spec/fixtures/ohio2014.p1622-v29.xml'
      doc = nil
      e = nil
      File.open(xml_file) do |f|
        doc = Nokogiri::XML(f)
      end
      File.open(xml_file) do |f|
        e = VSSC::Parser.parse(f)
      end
            
      expect(e.to_xml_node.doc.root).to be_equivalent_to(doc.root)
    end
  end
  
  
end
