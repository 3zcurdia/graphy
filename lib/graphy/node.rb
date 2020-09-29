module Graphy
  class Node
    attr_accessor :name, :shape, :diagram

    def self.for(node, **params)
      case node
      when Entity, Node
        node
      when String
        self.class.new(node, **params)
      else
        raise 'Invalid node class'
      end
    end

    def initialize(**params)
      @name = params[:name].to_s
      @diagram = params[:diagram]
      @shape = params.fetch(:shape, 'circle')
    end

    def add_dependency(dependency, **options)
      dependency = self.class.for(dependency, diagram: diagram)
      return if Registry.edges?(self, dependency)

      Registry.add_edges(self, dependency)
      diagram.add_edge(gnode, dependency.gnode, options)
    end
    alias :uses :add_dependency

    def build(diagram, &block)
      instance_eval(&block) if block_given?
      gnode
    end

    def gnode
      @gnode ||= draw
    end

    def draw
      diagram.draw_node(name, node_params)
    end

    def to_s
      "#{self.class}<#{name}>"
    end

    protected

    def node_params
      {
        label: label,
        shape: shape
      }
    end

    def label
      "#{name}\n"
    end
  end
end
