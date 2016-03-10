class Vedaspace::Parser
  # Create concrete instances of vedaspace models
  
  def self.instantiate_concrete_classes
    er_klass = Class.new do
      include Vedaspace::ElectionReport
    end
    Object.const_set("ConcreteElectionReport", er_klass)
    Vedaspace::ElectionReport.concrete_class_name = "ConcreteElectionReport"
    
    # also create concrete and registered classes for everything
    Dir[File.dirname(__FILE__) + '/*.rb'].each do |file|
      file_name_match  = /^.+\/(?<file_name>[^\/]+).rb$/
      if (fn = file_name_match.match(file)[:file_name]) && fn != 'enum' && fn != 'parser' && fn != 'version'
        puts fn
        class_name = fn.classify
        mod = "Vedaspace::#{class_name}".constantize
        concrete_class_name =  "Concrete#{class_name}"
        Object.const_set(concrete_class_name, Class.new { include mod })
        mod.send(:concrete_class_name=, concrete_class_name)
      end
      
    end
    
  end
  
  def self.parse_ved_file(file)
    self.instantiate_concrete_classes
    return ConcreteElectionReport.parse_ved_file(file)
  end
  
end