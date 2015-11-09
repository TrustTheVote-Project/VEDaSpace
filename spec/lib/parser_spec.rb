require_relative '../spec_helper.rb'

describe Vedaspace::Parser do

  describe 'XML import/export' do
    it "should import/export equivalent files" do
      xml_file = './spec/fixtures/NY_TEST.xml'
      doc = nil
      e = nil
      File.open(xml_file) do |f|
        doc = Nokogiri::XML(f)
      end
      File.open(xml_file) do |f|
        e = Vedaspace::Parser.parse_ved_file(f)
      end
            
      expect(e.to_xml_node.doc.root).to be_equivalent_to(doc.root)
    end
  end
  
  
end
