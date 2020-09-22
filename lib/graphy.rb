require 'graphviz'
require 'graphy/node'
require 'graphy/entity'
require 'graphy/dsl'
require 'graphy/registry'
require 'graphy/version'

module Graphy
  class Error < StandardError; end
  def self.define(name=nil, options={}, &block)
    Dsl.new(name, options, &block)
  end
end
