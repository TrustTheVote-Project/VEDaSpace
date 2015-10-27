Bundler.require
require 'vedastore'

RSpec.configure do |config|
  
  
end

require 'rspec/expectations'
require 'rspec/matchers' # req by equivalent-xml custom matcher `be_equivalent_to`
require 'equivalent-xml'

RSpec::Matchers.define :have_element do |expected|
  match do |inst|
    success = inst.respond_to?("#{expected.underscore}=")
    success &= inst.respond_to?("#{expected.underscore}")
    success && (inst.elements[expected][:method] == expected.underscore.to_sym) 
  end
  description { "have element for #{expected} "}
end


RSpec::Matchers.define :have_attribute do |expected|
  match do |inst|
    success = inst.respond_to?("#{expected.underscore}=")
    success &= inst.respond_to?("#{expected.underscore}")
    success && (inst.attributes[expected][:method] == expected.underscore.to_sym)
  end
  description { "have attribute for #{expected}"}
end


RSpec::Matchers.define :have_element_array do |expected|
  match do |inst|
    meth = inst.elements[expected][:method]
    inst.send(meth).is_a?(Array)
  end
  description { "have array element #{expected}"}
end

RSpec::Matchers.define :validate_element_array_type do |expected, instance|
  match do |inst|
    meth =  inst.elements[expected][:method]
    unless instance.is_a?(String)
      inst.send(meth) << "string"
    else
      inst.send(meth) << 0
    end
    success = !inst.valid?
    inst.send(meth).clear
    inst.send(meth) << instance
    success && inst.valid?
  end
  description { "should only accept #{instance.class} in array element #{expected}"}
end

RSpec::Matchers.define :validate_element_array_min_size do |expected, count|
  match do |inst|
    meth =  inst.elements[expected][:method]
    meth_type = inst.elements[expected][:type]
    inst.send(meth).clear
    (count - 1).times do 
      inst.send(meth) << meth_type.new
    end    
    success = !inst.valid?
    inst.send(meth) << meth_type.new

    success && inst.valid?
  end
  description do
    "have min size of #{count} for array element #{expected}"
  end
  
end

RSpec::Matchers.define :validate_presence_of_attribute do |expected|
  match do |inst|
    meth = inst.attributes[expected][:method]
    success = inst.valid?
    inst.send("#{meth}=",nil)
    success && !inst.valid?
  end
  description  do 
    "require presence of #{expected} attribute"
  end
end

RSpec::Matchers.define :validate_element_type do |expected, instance|
  match do |inst|
    meth =  inst.elements[expected][:method]
    unless instance.is_a?(String)
      inst.send("#{meth}=", "string")
    else
      inst.send("#{meth}=", 0)
    end
    success = !inst.valid?
    inst.send("#{meth}=", instance)
    success && inst.valid?
  end
  description { "only accept #{instance.class} types in element #{expected}"}
end


RSpec::Matchers.define :validate_attribute_type do |expected, instance|
  match do |inst|
    meth =  inst.attributes[expected][:method]
    unless instance.is_a?(String)
      inst.send("#{meth}=", "string")
    else
      inst.send("#{meth}=", 0)
    end
    success = !inst.valid?
    inst.send("#{meth}=", instance)
    success && inst.valid?
  end
  description { "only accept #{instance.class} types in attribute #{expected}"}
end
