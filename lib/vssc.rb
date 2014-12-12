require "active_support/all"

module VSSC
  
	
  module ClassAttributes
    module ClassMethods
      attr_reader :elements, :attributes
    
      def define_element(element_name, data_type=String)
        #puts self.class.to_s
        method_name = element_name.underscore
        #puts method_name
        @elements ||= {}
        @elements[element_name] = method_name.to_sym
        #@attributes ||= {}
        
        attr_accessor method_name
      end
    end
    
    
    def self.included(base)
      base.extend ClassMethods
    end

    def attributes
      self.class.attributes
    end
    def elements
      self.class.elements
    end
    
  end
  
  
  module Enum
    module ClassMethods
      def all
        self.enums
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


require 'vssc/election_report.rb'
require 'vssc/contest.rb'
require 'vssc/ballot_measure.rb'
