module Graphy
  class Dependency
    def self.for(reference, type: nil)
      case type
      when :parent
        Parent
      else
        Default
      end.new(reference)
    end

    class Default
      attr_accessor :ref
      def initialize(ref)
        @ref = ref
      end

      def edge_attributes
        {}
      end
    end

    class Parent < Default
      def edge_attributes
        { style: 'dotted', color: 'blue' }
      end
    end
  end
end
