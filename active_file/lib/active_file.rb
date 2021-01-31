# coding: utf-8

require_relative "active_file/version"

require "fileutils"
require "yaml"

require "rake"
import File.expand_path("tasks/db.rake", __FILE__)

module ActiveFile
    def save
        @new_record = false
        
        unless File.directory?("db/#{self.class}")
            FileUtils.mkdir_p("db/#{self.class}")
        end
        File.open("db/#{self.class}/#{@id}.yml", "w") do |file|
            file.puts(serialize)
        end
    end
    
    def destroy
        unless @destroyed or @new_record
            @destroyed = true
            FileUtils.rm("db/#{self.class}/#{@id}.yml")
        end
    end
    
    module ClassMethods
        def find(id)
            raise DocumentNotFound,
            "Arquivo db/#{self}/#{id}.yml não encontrado",
            caller unless File.exists?("db/#{self}/#{id}.yml")
            
            YAML.load(File.open("db/#{self}/#{id}.yml", "r"))
        end
        
        def next_id
            Dir.glob("db/#{self}/*.yml").size + 1
        end
        
        def field(name)
            @fields ||= []
            @fields << name
            
            get = %Q{
                def #{name}
                    @#{name}
                end
            }
            
            set = %Q{
                def #{name}=(valor)
                    @#{name} = valor
                end
            }
            
            self.class_eval get
            self.class_eval set
        end
        
        def method_missing(name, *args, &block)
            super unless name.to_s =~ /^find_by_(.*)/
            
            argument = args.first
            field = $1
            super if @fields.include?(field)
            
            load_all.select do |object|
                should_select?(object, field, argument)
            end
        end
        
        private
        def should_select?(object, field, argument)
            if argument.kind_of?(Regexp)
                object.send(field)=~argument
            else
                object.send(field)==argument
            end
        end
        
        def load_all
            Dir.glob("db/#{self}/*.yml").map do |file|
                deserialize(file)
            end
        end
        
        def deserialize(file)
            YAML.load(File.open(file, "r"))
        end
        
    end
    
    def self.included(base)
        base.extend(ClassMethods)
        
        base.class_eval do
            attr_reader :id, :destroyed, :new_record
            
            def initialize(parameters = {})
                @id = self.class.next_id
                @destroyed = false
                @new_record = true
                
                parameters.each do |key, value|
                    instance_variable_set "@#{key}", value
                end
            end
        end
    end
    
    private
    def serialize
        YAML.dump(self)
    end
end
