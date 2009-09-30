require 'find'

module Claw
  VERSION = '0.1.0'
end

%w[application].each do |f|
  require File.join(File.dirname(__FILE__), 'claw', f)
end

