module Graphy
  class Entity < Node
    def initialize(**params)
      super(**params.merge(shape: 'Mrecord'))
      @attributes = []
    end

    def attrs(*values)
      @attributes = values
    end

    def meths(*values)
      @attributes << values.map { |x| "#{x}()"}
    end

    protected

    def draw_edge(dependency, **options)
      diagram.draw_edge(dependency.gnode, gnode, options)
    end

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
