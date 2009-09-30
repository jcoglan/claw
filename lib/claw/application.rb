module Claw
  class Application
    
    def initialize(dir)
      @search = Search.new(dir)
    end
    
  end
end

