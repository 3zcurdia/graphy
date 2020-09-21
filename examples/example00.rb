require 'bundler/setup'
require 'graphviz/dsl'

digraph :example do
   cluster_0 do
      graph[label: 'Animal Kingdom']
      animal << dog
      animal << cat
   end
   friendly << dog

   output(png: "#{$0}.png")
end
