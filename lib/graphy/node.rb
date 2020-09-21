module Graphy
  class Node
    attr_accessor :graph, :name, :shape, :penwidth, :fontsize, :style, :fillcolor, :dependencies
    def initialize(name, graph:, shape: 'circle')
      @name = name
      @graph = graph
      @shape = shape
      @dependencies = []
    end

    def graph_node
      @graph_node ||= graph.add_nodes(name, node_attributes)
    end

    def add_dependency(dependency, type: nil)
      @dependencies << Dependency.for(dependency, type: type)
    end
    alias :uses :add_dependency

    protected

    def node_attributes
      {
        shape: shape,
        penwidth: penwidth,
        fontsize: fontsize,
        fontname: 'Helvetica',
        style: style,
        fillcolor: fillcolor,
        label: label
      }.compact
    end

    def label
      "#{name}\n"
    end
  end
end
