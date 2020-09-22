module Graphy
  class Node
    attr_accessor :graph, :name, :shape, :penwidth, :fontsize, :style, :fillcolor

    def self.find_or_create(name, options: {}, &block)
      return Registry.instance.nodes[name] if Registry.instance.node?(name)
      node = self.new(options.merge(name: name))
      node.build(&block)
      Registry.instance.nodes[name] = node
    end

    def initialize(**params)
      @name = params[:name].to_s
      @graph = params[:graph]
      @shape = params.fetch(:shape, 'circle')
    end

    def graph_node
      @graph_node ||= build_graph_node
    end

    def add_dependency(node, **options)
      node = self.class.find_or_create(node, options: {graph: graph}) unless node.is_a?(Node)
      return if Registry.instance.edge?(name, node.name)

      Registry.instance.edges << [name, node.name]
      graph.add_edge(node.graph_node, graph_node, options)
    end
    alias :uses :add_dependency

    def build(&block)
      instance_eval(&block) if block_given?
      build_graph_node
    end

    protected

    def build_graph_node
      return graph.get_node(name) if graph.get_node(name)
      graph.add_nodes(name, node_attributes)
    end

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
