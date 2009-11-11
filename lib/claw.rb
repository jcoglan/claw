require 'find'
require 'readline'
require 'oyster'

module Claw
  VERSION = '0.1.0'
  
  class Error < StandardError; end
end

%w[bin_spec application search].each do |f|
  require File.join(File.dirname(__FILE__), 'claw', f)
end

