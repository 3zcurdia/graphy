module Graphy
  class Entity < Node
    def initialize(name, graph:)
      super(name, graph: graph, shape: 'record')
      @attributes = []
    end

    def attributes(*values)
      @attributes = values
    end

    protected

    def label
      "{ #{name} #{attributes_label} }"
    end

    private

    def attributes_label
      return if @attributes.empty?
      "| #{@attributes.join("\n")}" 
    end
  end
end
