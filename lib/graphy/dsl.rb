module Graphy
  class Dsl
    @registry = {}
    @edges = []

    def self.registry
      @registry
    end

    def self.edges
      @edges
    end

    def initialize(name, options = {}, &block)
      @graph = GraphViz.new(name, map_options(options.merge(label: name)))
      instance_eval(&block) if block
    end

    def namespace(name, &block)
      opts = { parent: graph, type: graph.type }
      graph.add_graph(Dsl.new(name, opts, &block).graph)
    end

    def component(name, &block)
      node(name, shape: 'component', &block)
    end

    def note(name, &block)
      node(name, shape: 'note', &block)
    end

    def node(name, shape: 'circle', &block)
      return graph.get_node(name) unless graph.get_node(name.to_s).nil?

      node = Node.new(name, graph: graph, shape: shape)
      node.instance_eval(&block) if block_given?
      Dsl.registry[name] = node
    end

    def entity(name, parent = nil, &block)
      return graph.get_node(name) unless graph.get_node(name.to_s).nil?

      entity = Entity.new(name, graph: graph)
      entity.add_dependency(parent, type: :parent) if parent
      entity.instance_eval(&block) if block_given?
      Dsl.registry[name] = entity
    end

    def step(from, to:, options: {})
      return if Dsl.edges.any? { |x| [from, to] == x }
      source = Dsl.registry[from].graph_node
      dest = Dsl.registry[to].graph_node
      return if source.nil? || dest.nil?

      Dsl.edges << [from, to]
      graph.add_edge(source, dest, options)
    end

    def graph
      build
      @graph
    end

    def write(options = {})
      graph.output(options)
    end

    private

    def build
      Dsl.registry.each do |name, node|
        node.dependencies.each do |dep|
          step(dep.ref, to: name, options: dep.edge_attributes)
        end
      end
    end

    def map_options(options = {})
      align = options.delete(:align)
      rankdir = align == :horizontal ? 'LR' : nil
      options.merge(rankdir: rankdir).compact
    end
  end
end
