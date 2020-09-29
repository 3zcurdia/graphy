module Graphy
  class Entity < Node
    def initialize(**params)
      super(**params.merge(shape: 'Mrecord'))
      @attributes = []
    end

    def set(*values)
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
