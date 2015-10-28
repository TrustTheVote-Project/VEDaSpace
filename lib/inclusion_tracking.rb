module InclusionTracking
  
  def implementing_classes
    @implementing_classes ||= []
  end

  def register_inclusion(klass)
    puts 
    puts "#{self} registering #{klass}"
    self.implementing_classes << klass
  end
  
end