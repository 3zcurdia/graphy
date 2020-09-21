require 'bundler/setup'
require 'graphy'

Graphy.define 'Life View' do
  entity 'Friendly'
  entity 'Animal' do
    attributes :name, :other
  end

  entity 'Dog', 'Animal' do
    attributes :color
    uses 'Friendly'
  end

  entity 'Cat', 'Animal' do
    attributes :scratch
  end

  write png: "#{$0}.png"
end
