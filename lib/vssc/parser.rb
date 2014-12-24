require 'open-uri'
module VSSC
  class Parser
    
    def self.parse(file_contents_or_path)
      doc = nil
      begin
        doc = Nokogiri::XML(file_contents_or_path)
        if doc.elements.empty?
          doc = Nokogiri::XML(open(file_contents_or_path))
        end
      rescue
        doc = Nokogiri::XML(open(file_contents_or_path))
      end  
      # Should be ElectionReport
      ElectionReport.parse_vssc(doc.root)
      #doc.root.node_name
      
    end
    
    
    
  end
end