require "active_support/all"
require "active_model"

module VSSC
	
  module ClassAttributes
    module ClassMethods
      attr_accessor :elements, :attributes
    
      def define_xml_accessor(accessor_group, element_name, opts={})
        
        method_name = element_name.underscore
        element_type = opts[:type] || String
        
        self.send("#{accessor_group}=", (self.send(accessor_group) || {}))
      
        self.send(accessor_group)[element_name] ||= {}
        self.send(accessor_group)[element_name][:method] = method_name.to_sym
        self.send(accessor_group)[element_name][:type] = element_type
        self.send(accessor_group)[element_name][:multiple] = !!opts[:multiple]
        
        if opts[:required]
          validates_presence_of method_name
        end
        
        if opts[:type]
          validate("#{method_name}_type_validation")
          
          define_method "#{method_name}_type_validation" do
            return true if self.send(method_name).blank?
            valid_value = false
            if element_type == "xsd:dateTime" || element_type == "xsd:date"
              valid_value = is_valid_date_time?(self.send(method_name))
            elsif element_type == "xsd:boolean"
              valid_value = [true, false].include?(self.send(method_name))
            else
              valid_value = self.send(method_name).is_a?(element_type)
            end
            if !valid_value
              errors.add(method_name, "All #{element_name} must be #{element_type}")
            end
          end
        end
        
        if opts[:multiple]
          if opts[:min_size]
            validates_length_of method_name, is: opts[:min_size]
          end
          validate("#{method_name}_type_validation")
          
          define_method "#{method_name}_type_validation" do
            valid_value = true
            self.send(method_name).each {|val| valid_value = (valid_value && val.is_a?(element_type)) }
            if !valid_value
              errors.add(method_name, "All #{element_name} must be #{element_type}")
            end
          end
          
          define_method method_name do
            instance_variable_set("@#{method_name}", instance_variable_get("@#{method_name}") || [])
            instance_variable_get("@#{method_name}")
          end
          
          # define_method method_name.pluralize do
          #   self.send(method_name)
          # end
          
          define_method "#{method_name}=" do |val|
            raise 'Must be an array' if !val.is_a?(Array)
            instance_variable_set("@#{method_name}", val)
          end
        else
          attr_accessor method_name
        end
      end
    
      def define_element(element_name, opts={})
        define_xml_accessor(:elements, element_name, opts)
      end
      
      def define_attribute(element_name, opts={})
        define_xml_accessor(:attributes, element_name, opts)
      end
      
      def parse_vssc(node)
        e = self.new
        e.set_vssc_attributes(node.attributes)
        e.set_vssc_elements(node.elements)
        e
      end
      
      def is_type?(type_name)
        begin
          "VSSC::#{type_name}".constantize
          return true
        rescue
          return false
        end
      end
      
    end
    
    def self.included(base)
      base.extend ClassMethods
      base.send(:include, ActiveModel::Validations)
    end
    
    def is_valid_date_time?(value)
      begin
        return DateTime.iso8601(value.to_s).iso8601.to_s == value.to_s
      rescue
        return false
      end
    end

    def attributes
      (self.class.superclass == Object ? {} : (self.class.superclass.attributes || {})).merge(self.class.attributes || {})
    end
    
    def xml_attributes_hash(node_name)
      attr_hash = {}
      attributes.map do |k, options|
        v = convert_type_to_value(self.send(options[:method]), options[:type])
        attr_hash[k] = v unless v.nil?
      end
      if node_name != class_node_name && is_type?(node_name)
        attr_hash['xsi:type'] = class_node_name
      end
      return attr_hash
    end
    
    def is_type?(type_name)
      self.class.is_type?(type_name)
    end
    
    
    
    def elements
      (self.class.superclass == Object ? {} :( self.class.superclass.elements || {})).merge(self.class.elements || {})
    end
    
    
    def set_vssc_attributes(xml_attributes)
      xml_attributes.each do |key, value|
        if self.attributes.include?(key)
          self.send("#{attributes[key][:method]}=", convert_value_to_type(value.value, attributes[key][:type] ))
        elsif key.to_s != 'type'
          parse_error "Attribute #{key} not part of #{self.class}"
        end
      end
    end
    
    def set_vssc_elements(xml_elements)
      xml_elements.each do |element|
        if self.elements.include?(element.name)
          method = elements[element.name][:method]
          value =  convert_element_to_type(element, elements[element.name][:type])
          if elements[element.name][:multiple]
            self.send("#{method}") << value
          else
            self.send("#{method}=", value)
          end
        else
          parse_error "Element #{element.name} not part of #{self.class}"
        end
      end
    end
    
    def convert_element_to_type(element, obj_type)
      if obj_type.to_s == "String"
        element.children.first.to_s
      else
        klass = nil
        begin
          klass = "VSSC::#{(element.attributes['type'].value || element.attributes['xsi:type'].value || element.name)}".constantize
        rescue
          klass = obj_type
        end
        klass.parse_vssc(element)
      end
    end
    
    def convert_value_to_type(value, obj_type)
      if obj_type.is_a?(Class) && obj_type.ancestors.include?(VSSC::Enum)
        return obj_type.find(value)
      end
      case obj_type.to_s
      when "String"
        return value.to_s
      when "Fixnum"
        return value.blank? ? nil : value.to_i
      when "Float"
        return value.blank? ? nil : value.to_f
      when "xsd:date", "xsd:dateTime"
        return value.blank? ? nil : DateTime.iso8601(value)
      when "xsd:boolean"
        return (!value.blank? && !["0","false","nil","null"].include?(value.to_s.downcase))
      else
        return value.to_s
      end
    end
    
    def convert_type_to_value(value, obj_type)
      case obj_type.to_s
      when "xsd:date"
        return value.blank? ? nil : value.iso8601.gsub(/T.*/,'')
      when "xsd:dateTime"
        return value.blank? ? nil : value.iso8601.gsub("+00:00","Z")
      when "xsd:boolean"
        return value.nil? ? nil : value.to_s
      when "Float"
        return value.blank? ? nil : value.to_s.chomp('.0')
      else
        return (value.to_s == "") ? nil : value.to_s
      end
    end
    
    def parse_error(msg)
      puts "Error: #{msg}"
    end
    
    def class_node_name
      self.class.name.split('::').last
    end
    
    def to_xml_node(xml = nil, node_name = nil)
      node_name ||= class_node_name
      xml ||= Nokogiri::XML::Builder.new
      xml.send(node_name, xml_attributes_hash(node_name)) do |r|
        elements.each do |k, options|
          value = self.send(options[:method])           
          if !value.nil? && (!value.is_a?(Array) || !value.empty?)       
            if options[:type].to_s =~ /VSSC::/
              if !value.is_a?(Array)
                value = [value]
              end
              value.each do |v|
                v.to_xml_node(r, k)
              end
            else
              if !value.is_a?(Array)
                value = [value]
              end
              value.each do |v|
                r.send(k, convert_type_to_value(v, options[:type]))
              end
            end
          end
        end
      end
      return xml
    end
    
  end
  
  
  module Enum
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
          inst = self.new(val)
          @enums << inst
          @enums << val
          self.class.instance_eval do
            define_method(val.gsub('-','_')) { inst }
          end
        end
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
    
	# <xsd:simpleType name="BallotCountStatus">
  #     <xsd:restriction base="xsd:string">
  #       <xsd:enumeration value="completed"/>
  #       <xsd:enumeration value="in-process"/>
  #       <xsd:enumeration value="not-processed"/>
  #       <xsd:enumeration value="unknown"/>
  #     </xsd:restriction>
  #   </xsd:simpleType>
  class BallotCountStatus
    include VSSC::Enum
    
    set_enum_values "completed", "in-process", "not-processed", "unknown"
  end
  
  # <xsd:simpleType name="BallotType">
  #   <xsd:restriction base="xsd:string">
  #     <xsd:enumeration value="absentee"/>
  #     <xsd:enumeration value="absentee-FWAB"/>
  #     <xsd:enumeration value="absentee-in-person"/>
  #     <xsd:enumeration value="absentee-mail"/>
  #     <xsd:enumeration value="absentee-UOCAVA"/>
  #     <xsd:enumeration value="early"/>
  #     <xsd:enumeration value="election-day"/>
  #     <xsd:enumeration value="other"/>
  #     <xsd:enumeration value="provisional"/>
  #     <xsd:enumeration value="total"/>
  #     <xsd:enumeration value="UOCAVA"/>
  #   </xsd:restriction>
  # </xsd:simpleType>
  class BallotType
    include VSSC::Enum
    
    set_enum_values "absentee",
                    "absentee-FWAB",
                    "absentee-in-person",
                    "absentee-mail",
                    "absentee-UOCAVA",
                    "early",
                    "election-day",
                    "other",
                    "provisional",
                    "total",
                    "UOCAVA"
  
  end
  
  
  # <xsd:simpleType name="CandidateStatus">
  #   <xsd:restriction base="xsd:string">
  #     <xsd:enumeration value="advanced-to-runoff"/>
  #     <xsd:enumeration value="filed"/>
  #     <xsd:enumeration value="qualified"/>
  #     <xsd:enumeration value="winner"/>
  #     <xsd:enumeration value="withdrawn"/>
  #     <xsd:enumeration value="writein"/>
  #   </xsd:restriction>
  # </xsd:simpleType>
  class CandidateStatus
    include VSSC::Enum
    
    set_enum_values "advanced-to-runoff",
                    "filed",
                    "qualified",
                    "winner",
                    "withdrawn",
                    "writein"
    
    
    
  end
  
  
  # <xsd:simpleType name="DeviceType">
  #   <xsd:restriction base="xsd:string">
  #     <xsd:enumeration value="electronic"/>
  #     <xsd:enumeration value="lever"/>
  #     <xsd:enumeration value="manual-count"/>
  #     <xsd:enumeration value="mixed-systems"/>
  #     <xsd:enumeration value="opscan-central"/>
  #     <xsd:enumeration value="opscan-precinct"/>
  #     <xsd:enumeration value="punch-card"/>
  #     <xsd:enumeration value="unknown"/>
  #   </xsd:restriction>
  # </xsd:simpleType>
  class DeviceType
    include VSSC::Enum
    
    set_enum_values "electronic",
                    "lever",
                    "manual-count",
                    "mixed-systems",
                    "opscan-central",
                    "opscan-precinct",
                    "punch-card",
                    "unknown"
    
  end
  
  
  # <xsd:simpleType name="DistrictType">
  #   <xsd:restriction base="xsd:string">
  #     <xsd:enumeration value="congressional"/>
  #     <xsd:enumeration value="local"/>
  #     <xsd:enumeration value="locality"/>
  #     <xsd:enumeration value="other"/>
  #     <xsd:enumeration value="state-house"/>
  #     <xsd:enumeration value="state-senate"/>
  #     <xsd:enumeration value="statewide"/>
  #   </xsd:restriction>
  # </xsd:simpleType>
  class DistrictType
    include VSSC::Enum
    
    set_enum_values "congressional",
                    "local",
                    "locality",
                    "other",
                    "state-house",
                    "state-senate",
                    "statewide"
    
    
  end
  
  
  
  # <xsd:simpleType name="ElectionType">
  #   <xsd:restriction base="xsd:string">
  #     <xsd:enumeration value="general"/>
  #     <xsd:enumeration value="other"/>
  #     <xsd:enumeration value="partisan-primary-closed"/>
  #     <xsd:enumeration value="partisan-primary-open"/>
  #     <xsd:enumeration value="primary"/>
  #     <xsd:enumeration value="runoff"/>
  #     <xsd:enumeration value="special"/>
  #   </xsd:restriction>
  # </xsd:simpleType>
  class ElectionType
    include VSSC::Enum
    
    set_enum_values "general",
                    "other",
                    "partisan-primary-closed",
                    "partisan-primary-open",
                    "primary",
                    "runoff",
                    "special"    
    
  end
  
  
  # <xsd:simpleType name="EthnicityType">
  #   <xsd:restriction base="xsd:string">
  #     <xsd:enumeration value="asian"/>
  #     <xsd:enumeration value="black"/>
  #     <xsd:enumeration value="hispanic"/>
  #     <xsd:enumeration value="moreThanOne"/>
  #     <xsd:enumeration value="nativeAmerican"/>
  #     <xsd:enumeration value="white"/>
  #     <xsd:enumeration value="unknown"/>
  #   </xsd:restriction>
  # </xsd:simpleType>
  class EthnicityType
    include VSSC::Enum
    
    set_enum_values "asian",
                    "black",
                    "hispanic",
                    "moreThanOne",
                    "nativeAmerican",
                    "white",
                    "unknown"  
    
  end
  
  
  # <xsd:simpleType name="GenderType">
  #   <xsd:restriction base="xsd:string">
  #     <xsd:enumeration value="female"/>
  #     <xsd:enumeration value="male"/>
  #     <xsd:enumeration value="unknown"/>
  #   </xsd:restriction>
  # </xsd:simpleType>
  class GenderType
    include VSSC::Enum
    
    set_enum_values "female",
                    "male",
                    "unknown"  
    
  end
  
  # <xsd:simpleType name="ReportFormat">
  #   <xsd:restriction base="xsd:string">
  #     <xsd:enumeration value="precinct-level"/>
  #     <xsd:enumeration value="summary-contest"/>
  #   </xsd:restriction>
  # </xsd:simpleType>
  class ReportFormat
    include VSSC::Enum
    
    set_enum_values "precinct-level",
                    "summary-contest"    
    
  end
  
  
  
  
  # <xsd:simpleType name="ReportStatus">
  #   <xsd:restriction base="xsd:string">
  #     <xsd:enumeration value="certified"/>
  #     <xsd:enumeration value="correction"/>
  #     <xsd:enumeration value="pre-election"/>
  #     <xsd:enumeration value="recount"/>
  #     <xsd:enumeration value="test"/>
  #     <xsd:enumeration value="unofficial-complete"/>
  #     <xsd:enumeration value="unofficial-partial"/>
  #   </xsd:restriction>
  # </xsd:simpleType>
  class ReportStatus
    include VSSC::Enum
    
    set_enum_values  "certified",
                     "correction",
                     "pre-election",
                     "recount",
                     "test",
                     "unofficial-complete",
                     "unofficial-partial"
    
    
  end 
  
  # <xsd:simpleType name="ReportingUnitType">
  #   <xsd:restriction base="xsd:string">
  #     <xsd:enumeration value="audit-batch"/>
  #     <xsd:enumeration value="city"/>
  #     <xsd:enumeration value="combined-precinct"/>
  #     <xsd:enumeration value="county"/>
  #     <xsd:enumeration value="jurisdiction"/>
  #     <xsd:enumeration value="municipality"/>
  #     <xsd:enumeration value="other"/>
  #     <xsd:enumeration value="polling-place"/>
  #     <xsd:enumeration value="precinct"/>
  #     <xsd:enumeration value="split-precinct"/>
  #     <xsd:enumeration value="state"/>
  #     <xsd:enumeration value="township"/>
  #     <xsd:enumeration value="vote-center"/>
  #   </xsd:restriction>
  # </xsd:simpleType>
  class ReportingUnitType
    include VSSC::Enum
    
    set_enum_values "audit-batch",
                    "city",
                    "combined-precinct",
                    "county",
                    "jurisdiction",
                    "municipality",
                    "other",
                    "polling-place",
                    "precinct",
                    "split-precinct",
                    "state",
                    "township",
                    "vote-center"    
    
  end 
  
  
  # <xsd:simpleType name="VoteVariation">
  #   <xsd:restriction base="xsd:string">
  #     <xsd:enumeration value="approval"/>
  #     <xsd:enumeration value="cumulative"/>
  #     <xsd:enumeration value="IRV"/>
  #     <xsd:enumeration value="N-of-M"/>
  #   </xsd:restriction>
  # </xsd:simpleType>
  class VoteVariation
    include VSSC::Enum
    
    set_enum_values "approval",
                    "cumulative",
                    "IRV",
                    "N-of-M"
        
  end 
  
end

require_relative 'vssc/party_registration.rb'
require_relative 'vssc/spatial_extent.rb'
require_relative 'vssc/spatial_dimension.rb'
require_relative 'vssc/counts.rb'
require_relative 'vssc/total_counts.rb'
require_relative 'vssc/gp_unit.rb'
require_relative 'vssc/vote_counts.rb'
require_relative 'vssc/ballot_selection.rb'
require_relative 'vssc/contest.rb'
require_relative 'vssc/contest_collection.rb'
require_relative 'vssc/contact.rb'
require_relative 'vssc/ordered_contest.rb'
require_relative 'vssc/ballot_measure.rb'
require_relative 'vssc/ballot_measure_selection.rb'
require_relative 'vssc/ballot_style.rb'
require_relative 'vssc/ballot_style_collection.rb'
require_relative 'vssc/candidate.rb'
require_relative 'vssc/candidate_choice.rb'
require_relative 'vssc/candidate_collection.rb'
require_relative 'vssc/candidate_selection.rb'
require_relative 'vssc/device.rb'
require_relative 'vssc/district.rb'
require_relative 'vssc/office.rb'
require_relative 'vssc/party.rb'
require_relative 'vssc/person.rb'
require_relative 'vssc/reporting_unit.rb'
require_relative 'vssc/straight_party.rb'

require_relative 'vssc/gp_unit_collection.rb'
require_relative 'vssc/party_collection.rb'
require_relative 'vssc/person_collection.rb'
require_relative 'vssc/office_collection.rb'

require_relative 'vssc/election.rb'

require_relative 'vssc/election_report.rb'

require_relative 'vssc/parser.rb'
