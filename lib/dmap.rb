#load './lib/dmap.rb'; load './lib/hart/mapper.rb'
require 'csv'

module DMap
  
  def self.find(class_name, id)
    ModelRegister.classes[class_name].find(id)
  end
  
  
  class File
    def self.process_options(opts)
      return {
        path: './',
        headers: true,
        format: :csv
      }.merge(opts)
    end
    
    def self.define(file_name, options)
      opts = process_options(options.dup)
      csv_opts = {}
      csv_opts[:headers]=opts[:headers]
      csv_opts[:col_sep]= "\t" if opts[:format] == :tdf 
      rows = CSV.read(::File.join(opts[:path], file_name), csv_opts)
      yield DMap::File::Definer.new(rows)
    end
    
    def self.define_relation(file_name, options, &block)
      #for now it's the same thing as the define
      self.define(file_name, options, &block)
    end
    
    
    
    class Definer
      def initialize(rows)
        @rows = rows
      end
      
      def method_missing(method, *args, &block)
        # method will be defining a new model, args will be a list of 
        #    symbols (column names) or 
        #    hashes (relations) {col_name=>[other class, other class column]}
        klass = DMap::ModelRegister.define_class(method, *args)
        klass.csv_data_rows = @rows
      end
    end
  end
  
  class Model
    
    class << self    
      attr_accessor :model_name
      attr_accessor :csv_data_rows
    end
    def self.set_model_name(value)
      @model_name=value
    end
    def self.columns
      @columns ||= {}
    end
    def self.relations
      @relations ||= {}
    end
        
    def self.col_attr_reader(col_name, col_num)
      self.columns[col_num] = col_name
    end
    def self.set_relation(model, model_col, col)
      self.relations[model] = {:key=>col, :foreign_key=>model_col}
    end
    def self.relation_columns
      relation_columns ={}
      self.relations.each do |k,v|
        relation_columns[v[:key]] = [k, v[:foreign_key]]
      end
      return relation_columns
    end
    def self.is_relation?(col)
      self.relation_columns.keys.include?(col)
    end
    
    def find_relation_instances(relation_name, key, foreign_key)
      klass = ModelRegister.classes[relation_name]
      items = klass.find_all_by_column(foreign_key, self.attributes[key])
    end
    
    def relations(rel_name)
      @relations ||= find_relations
      @relations[rel_name]
    end
    
    def find_relations(options={})
      opts = {:except=>[]}.merge(options.dup)
      rels = {}
      
      if self.class.relation_columns.any?
        self.class.relation_columns.each do |col, foreign|
          rel_name = foreign[0]
          foreign_key = foreign[1]
          if !opts[:except].include?(rel_name)
            opts[:except] << rel_name
            rels[rel_name] = find_relation_instances(rel_name, col, foreign_key)
          end
        end
      end
      
      ModelRegister.classes.each do |klass_name, klass|
        if !opts[:except].include?(klass_name) && klass.relations[self.class.model_name]
          relation = klass.relations[self.class.model_name]
          items = klass.find_all_by_column(relation[:key], self.attributes[relation[:foreign_key]])
          rels[klass_name] = items
        end
      end
      return rels
    end
    
    def self.find(id)
      all[id]
    end
    
    def self.all
      all = {}
      csv_data_rows.each_with_index do |row,i|
        m = self.new
        row.each_with_index do |value, i|
          m.set_attribute(i, value)
        end
        index = m.attributes.keys.include?(:id) ? m.attributes[:id] : i
        if all[index]
          if all[index] == m
            next
          else
            #raise "#{all[index].inspect} not equal to #{m.inspect}"
          end
        else
          all[index] = m
        end
      end
      return all
    end
    
    def self.find_all_by_column(col_name, value)
      results = []
      self.all.values.each do |obj|
        if obj.attributes[col_name]==value
          results << obj 
        end
      end
      return results
    end
    
    
    def attributes
      @attributes ||= {}
    end
    def value_attributes
      relation_keys = self.class.relation_columns.keys
      return attributes.dup.reject do |key, value|
        relation_keys.include?(key)
      end
    end
    def set_attribute(i,value)
      col_name = self.class.columns[i]
      unless col_name == :NA
        self.attributes[col_name]=value
      end
    end
    
    def method_missing(method_sym, *arguments, &block)
      if attributes.has_key?(method_sym)
        return attributes[method_sym]
      else
        super
      end
    end
    

    
  end
  
  class ModelRegister
    class << self    
      attr_reader :classes
    end
    @classes = {}
    
    def self.define_class(class_name, *args)
      #dynamic_name = "DMap::Model::#{class_name}"
      
      klass = Class.new(DMap::Model) do
        set_model_name(class_name)
        args.each_with_index do |arg, col_num|
          if arg.is_a?(Symbol)
            col_attr_reader(arg, col_num)
          elsif arg.is_a?(Hash)
            col_attr_reader(arg.keys[0], col_num)
            # model name, model column, this column
            set_relation(arg.values[0][0], arg.values[0][1], arg.keys[0])
          end
        end
      end
      
      #Object.const_set(dynamic_name, klass)
      self.classes[class_name] = klass #Object.const_get(dynamic_name)
      return klass
    end
    
  end


  class Report
    
    attr_accessor :report_type
    
    def initialize(report_type)
      @report_type = report_type
    end
    
    def inst_relations(m_inst, renderer, processed_classes, render_method, depth=0, rollup_model=nil, rollups={})
      pr = processed_classes.dup
      m_inst.find_relations(:except=>processed_classes).each do |mr_inst_name, mr_inst_list|
        mr_inst_list.each do |mr_inst|
          if rollup_model
            if rollup_model == mr_inst_name && !rollups.keys.include?(mr_inst.attributes[:id])
              rollups[mr_inst.attributes[:id]] = mr_inst
              render_method.call(mr_inst_name, mr_inst, renderer, depth)
            end
          else
            render_method.call(mr_inst_name, mr_inst, renderer, depth)
          end
          inst_relations(mr_inst, renderer, pr + [mr_inst_name], render_method, depth+1, rollup_model, rollups)
        end        
      end
    end
    
    def to_text
      Proc.new do |instance_name, instance, renderer, depth=0|
        pre = []
        depth.times { pre << "\t"}
        pre = pre.join    
        renderer << "#{pre}#{instance_name}:"
        instance.value_attributes.each do |key, value|
          renderer << "\t#{pre}#{key}: #{value}"
        end
      end
    end
    
    
    def text
      top_level_model = nil
      rollup_model = nil
      if report_type.is_a?(Hash)
        top_level_model = report_type.keys.first
        rollup_model = report_type.values.first
      else
        top_level_model = report_type
      end
      txt = []
      processed_classes = [top_level_model]
      m = ModelRegister.classes[top_level_model]
      raise "Can't find class #{top_level_model} in #{ModelRegister.classes.keys}" if !m
      
      m.all.values.each do |m_inst|
        to_text.call(top_level_model, m_inst, txt)
        inst_relations(m_inst, txt, processed_classes, to_text, 1, rollup_model)
        txt << "-------------------------"
      end
      return txt
    end
    
  end

end  
