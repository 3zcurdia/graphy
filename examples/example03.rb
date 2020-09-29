require 'bundler/setup'
require 'graphy'

Graphy.define 'Life View' do
  entity 'Friendly'
  namespace 'Animal Kingdom' do
    entity 'Animal'
    entity 'Dog', 'Animal' do
      uses 'Friendly'
    end
    entity 'Cat', 'Animal'
  end

  write png: "#{$0}.png"
end
