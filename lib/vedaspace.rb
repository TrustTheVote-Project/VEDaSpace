require "active_support/all"
require "active_model"
require 'xsd_functions'
require 'inclusion_tracking'

module Vedaspace
end

require_relative 'vedaspace/enum'

# Dir[File.dirname(__FILE__) + '/vedaspace/enum/*.rb'].each {|file| require file }

# require_relative 'vssc/party_registration.rb'
# require_relative 'vssc/spatial_extent.rb'
# require_relative 'vssc/spatial_dimension.rb'
# require_relative 'vssc/counts.rb'
# require_relative 'vssc/total_counts.rb'
# require_relative 'vssc/gp_unit.rb'
# require_relative 'vssc/vote_counts.rb'
# require_relative 'vssc/ballot_selection.rb'
# require_relative 'vssc/contest.rb'
# require_relative 'vssc/contest_collection.rb'
# require_relative 'vssc/contact.rb'
# require_relative 'vssc/ordered_contest.rb'
# require_relative 'vssc/ballot_measure.rb'
# require_relative 'vssc/ballot_measure_selection.rb'
# require_relative 'vssc/ballot_style.rb'
# require_relative 'vssc/ballot_style_collection.rb'
# require_relative 'vssc/candidate.rb'
# require_relative 'vssc/candidate_choice.rb'
# require_relative 'vssc/candidate_collection.rb'
# require_relative 'vssc/candidate_selection.rb'
# require_relative 'vssc/device.rb'
# require_relative 'vssc/district.rb'
# require_relative 'vssc/office.rb'
# require_relative 'vssc/party.rb'
# require_relative 'vssc/person.rb'
# require_relative 'vssc/reporting_unit.rb'
# require_relative 'vssc/straight_party.rb'
#
# require_relative 'vssc/gp_unit_collection.rb'
# require_relative 'vssc/party_collection.rb'
# require_relative 'vssc/person_collection.rb'
# require_relative 'vssc/office_collection.rb'
#
require_relative 'vedaspace/election.rb'
#
require_relative 'vedaspace/election_report.rb'
#
# require_relative 'vssc/parser.rb'
