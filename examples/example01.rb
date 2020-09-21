require 'bundler/setup'
require 'graphy'

Graphy.define do
  node 'A'
  node 'B', shape: 'diamond'
  node 'C'
  node 'D', shape: 'egg'

  step 'A', to: 'B'
  step 'B', to: 'C'
  step 'C', to: 'A'
  step 'C', to: 'D'
  step 'D', to: 'C'

  write png: "#{$0}.png"
end
