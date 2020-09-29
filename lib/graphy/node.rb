module Graphy
  class Node
    attr_accessor :name, :shape, :diagram

    def self.for(node, **params)
      case node
      when Entity, Node
        node
      when String
        self.new(**params.merge(name: node))
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
      return if Registry.edge?(self, dependency)

      Registry.add_edge(self, dependency)
      draw_edge(dependency, **options)
    end
    alias :uses :add_dependency

    def build(&block)
      instance_eval(&block) if block_given?
      gnode
    end

    def gnode
      @gnode ||= find_or_draw
    end

    def to_s
      "#{self.class}<#{name}>"
    end

    protected

    def draw_edge(dependency, **options)
      diagram.draw_edge(gnode, dependency.gnode, options)
    end

    def node_params
      {
        label: label,
        shape: shape
      }
    end

    def label
      "#{name}\n"
    end

    private

    def find_or_draw
      return diagram.get_node(name) if diagram.node_exists?(name)
      diagram.draw_node(name, node_params)
    end
  end
end
