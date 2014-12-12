require_relative '../spec_helper.rb'
require 'open-uri'

describe VSSC::Enum do
  
  describe 'The XSD specifies the enum classes' do
    xsd = Nokogiri::XML(open("spec/ElectionResultsV29.xsd.xml"))
    xsd.xpath("//xsd:simpleType").each do |node|
      klass = Kernel.const_get("VSSC::#{node["name"]}")
      describe klass do
        node.xpath("xsd:restriction/xsd:enumeration").each do |enum_value_node|
          enum_value = enum_value_node["value"]
          it "has an enum value '#{enum_value}'" do
            expect(klass.values).to include(enum_value)
          end
          it "has a class method for the enum value" do
            expect(klass).to respond_to(enum_value.gsub("-",'_'))
          end
        end
      end
    end
  end

end