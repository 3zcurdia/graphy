module Graphy
  ## GraphViz wrapper
  class Diagram
    attr_accessor :graph, :edges

    GRAPH_ATTRIBUTES = {
      ranksep:     0.5,
      nodesep:     0.4,
      pad:         '0.4,0.4',
      margin:      '0,0',
      concentrate: true,
      labelloc:    :t,
      fontsize:    11,
      fontname:    'Arial BoldMT',
      splines:     'spline'
    }

    NODE_ATTRIBUTES = {
      shape:    "Mrecord",
      fontsize: 10,
      fontname: "ArialMT",
      margin:   "0.07,0.05",
      penwidth: 1.0
    }

    EDGE_ATTRIBUTES = {
      fontname:      "ArialMT",
      fontsize:      7,
      dir:           :both,
      arrowsize:     0.9,
      penwidth:      1.0,
      labelangle:    32,
      labeldistance: 1.8,
    }

    def initialize(name, options = {})
      graph_opts = {
        parent: options[:parent],
        type: options[:parent]&.type
      }.compact
      @graph = GraphViz.new(name, **graph_opts)

      GRAPH_ATTRIBUTES.each { |attribute, value| @graph[attribute] = value }
      NODE_ATTRIBUTES.each  { |attribute, value| @graph.node[attribute] = value }
      EDGE_ATTRIBUTES.each  { |attribute, value| @graph.edge[attribute] = value }

      @graph[:rankdir] = options[:orientation] == :horizonal ? :LR : :TB
      @graph[:label] = "#{name}\\n\\n"
      @edges = []
    end

    def get_node(name)
      graph.search_node(name)
    end

    def node_exists?(name)
      !!get_node(name)
    end

    def draw_node(name, options = {})
      graph.add_nodes(name, options)
    end

    def draw_edge(from, to, options)
      return if Registry.edges?(from, to)
      graph.add_edges(from), to, options)
    end

    def draw_graph(name, options={}, &block)
      graph.add_graph(Diagram.new(name, options.merge(parent: self.graph), &block).graph)
    end

    def write(options = {})
      graph.output(options)
    end
  end
end
