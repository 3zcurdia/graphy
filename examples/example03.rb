require 'bundler/setup'
require 'graphy'

Graphy.define 'Life View' do
  entity 'Friendly'

  namespace 'Animal Kingdom' do
    entity 'Animal' do
      attrs :name, :other
    end

    entity 'Dog', 'Animal' do
      attrs :color
      uses 'Friendly'
    end

    entity 'Cat', 'Animal' do
      meths :scratch
    end
  end

  write png: "#{$0}.png"
end
