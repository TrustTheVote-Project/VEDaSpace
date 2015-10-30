module InclusionTracking
  def self.extended(base)
    base.send(:mattr_accessor, :concrete_class_name)
  end
end