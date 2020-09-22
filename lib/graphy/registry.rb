require 'singleton'

module Graphy
  class Registry
    include Singleton
    attr_accessor :nodes, :edges

    def initialize
      @nodes = {}
      @edges = []
    end

    def node?(name)
      nodes.key?(name)
    end

    def edge?(source, destiny)
      edges.any? { |x| [source, destiny] == x }
    end
  end
end
