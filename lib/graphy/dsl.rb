module Graphy
  class Dsl
    attr_accessor :diagram

    def initialize(name, options = {}, &block)
      @diagram = Diagram.new(name, options, &block)
      instance_eval(&block) if block_given?
    end

    # def namespace(name, &block)
    #   diagram.draw_graph(name, { parent: diagram.graph }, &block)
    # end

    def component(name, &block)
      node(name, shape: 'component', &block)
    end

    def note(name, &block)
      node(name, shape: 'note', &block)
    end

    def node(name, shape: 'circle', &block)
      options = {diagram: diagram, shape: shape}
      Node.for(name, **options).build(&block)
    end

    def entity(name, parent = nil, &block)
      entity = Entity.new(name: name, diagram: diagram)
      entity.build(&block)
      entity.add_dependency(parent, color: 'blue') if parent
    end

    def step(from, to:, **options)
      Node.for(from, diagram: diagram).add_dependency(to, **options)
    end

    def write(options = {})
      diagram.write(options)
    end
  end
end
