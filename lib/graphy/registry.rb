require 'singleton'

module Graphy
  class Registry
    include Singleton
    attr_accessor :edges

    def self.edge?(source, destiny)
      instance.edge?(source, destiny)
    end

    def self.add_edge(source, destiny)
      instance.add_edge(source, destiny)
    end

    def initialize
      @edges = {}
    end

    def edge?(source, destiny)
      edges.key?("#{source}->#{destiny}")
    end

    def add_edge(source, destiny, options = {})
      self.edges["#{source}->#{destiny}"] = options
    end
  end
end
