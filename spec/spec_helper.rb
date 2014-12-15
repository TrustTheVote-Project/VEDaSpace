Bundler.require
require 'vssc'

RSpec.configure do |config|
  
  
end


RSpec::Matchers.define :have_element do |expected|
  match do |inst|
    expect(inst).to respond_to("#{expected.underscore}=")
    expect(inst).to respond_to("#{expected.underscore}")
    expect(inst.elements[expected][:method]).to eq(expected.underscore.to_sym)
  end
end


RSpec::Matchers.define :have_attribute do |expected|
  match do |inst|
    expect(inst).to respond_to("#{expected.underscore}=")
    expect(inst).to respond_to("#{expected.underscore}")
    expect(inst.attributes[expected][:method]).to eq(expected.underscore.to_sym)
  end
end


RSpec::Matchers.define :have_element_array do |expected|
  match do |inst|
    meth = inst.elements[expected][:method]
    expect(inst.send(meth)).to be_a(Array)  
  end
end

RSpec::Matchers.define :validate_element_array_type do |expected, instance|
  match do |inst|
    meth =  inst.elements[expected][:method]
    unless instance.is_a?(String)
      inst.send(meth) << "string"
    else
      inst.send(meth) << 0
    end
    expect(inst).to_not be_valid
    inst.send(meth).clear
    inst.send(meth) << instance
    expect(inst).to be_valid
  end
end

RSpec::Matchers.define :validate_presence_of_attribute do |expected|
  match do |inst|
    meth = inst.attributes[expected][:method]
    inst.send("#{meth}=",nil)
    expect(inst).to_not be_valid
    inst.send("#{meth}=","abc")
    expect(inst).to be_valid
  end
end
