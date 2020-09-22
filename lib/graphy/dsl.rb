module Graphy
  class Dsl
    attr_accessor :graph

    def initialize(name, options = {}, &block)
      @graph = GraphViz.new(name, map_options(options.merge(label: name)))
      instance_eval(&block) if block_given?
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
      options = {graph: graph, shape: shape}
      Node.find_or_create(name, options: options, &block)
    end

    def entity(name, parent = nil, &block)
      return Registry.instance.nodes[name] if Registry.instance.node?(name)

      entity = Entity.new(name: name, graph: graph)
      entity.build(&block)
      entity.add_dependency(parent, color: 'blue') if parent
      Registry.instance.nodes[name] = entity
    end

    def step(from, to:, **options)
      source = Registry.instance.nodes[from]
      dest = Registry.instance.nodes[to]
      return if source.nil? || dest.nil?

      dest.add_dependency(source, **options)
    end

    def write(options = {})
      graph.output(options)
    end

    private

    def map_options(options = {})
      align = options.delete(:align)
      rankdir = align == :horizontal ? 'LR' : nil
      options.merge(rankdir: rankdir).compact
    end
  end
end
