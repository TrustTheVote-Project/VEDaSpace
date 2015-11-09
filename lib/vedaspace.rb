require "active_support/all"
#require "active_model"
require 'xsd_functions'
require 'inclusion_tracking'

module Vedaspace
end

require_relative 'vedaspace/enum'

Dir[File.dirname(__FILE__) + '/vedaspace/*.rb'].each {|file| require file }