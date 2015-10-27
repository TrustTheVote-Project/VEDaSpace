require 'open-uri'
module VSSC
  class Parser
    
    def self.noko_doc(file_contents_or_path)
      doc = nil
      begin
        doc = Nokogiri::XML(file_contents_or_path) { |config| config.noblanks }
        if doc.elements.empty?
          doc = Nokogiri::XML(open(file_contents_or_path)) { |config| config.noblanks }
        end
      rescue
        doc = Nokogiri::XML(open(file_contents_or_path)) { |config| config.noblanks }
      end
      doc  
    end
    
    def self.parse(file_contents_or_path)
      # Should be ElectionReport
      ElectionReport.parse_vssc(noko_doc(file_contents_or_path).root)
      #doc.root.node_name
    end
    
  end
end