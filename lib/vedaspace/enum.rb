module Vedaspace::Enum
  module ClassMethods
    def all
      self.enums
    end
    
    def find(string_val)
      enums.detect {|e| e.to_s.downcase == string_val.to_s.downcase}
    end
  
    def enums
      @enums ||= []
      @enums
    end
    
    def values
      enums.collect(&:to_s)
    end
    
    def set_enum_values(*args)
      @enums = []
      args.each do |val|
        v = val.underscore
        inst = self.new(val)
        @enums << inst
        @enums << val
        self.class.instance_eval do
          define_method(v.gsub('-','_')) { inst }
        end
      end
    end
  
    def parse_ved(node)
      return self.new(node.text)
    end
  
  
  end
  
  
  
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  attr_reader :value

  def to_s
    value
  end

  def initialize(val)
    @value = val
  end
  
end

Dir[File.dirname(__FILE__) + '/enum/*.rb'].each {|file| require file }
