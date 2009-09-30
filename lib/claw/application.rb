module Claw
  class Application
    
    def initialize(dir)
      @dir = File.expand_path(dir)
      raise "Not a directory: #{@dir}" unless File.directory?(@dir)
    end
    
    def find_by_name(query)
      results = []
      pattern = %r{#{ query.strip.split('').map(&Regexp.method(:escape)) * '.*' }}i
      Find.find(@dir) do |path|
        next unless File.file?(path)
        path = path.sub(@dir + '/', '')
        results << path if path =~ pattern
      end
      results.sort
    end
    
  end
end

