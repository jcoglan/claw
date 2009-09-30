module Claw
  class Search
    
    def initialize(dir)
      @dir = File.expand_path(dir)
      raise "Not a directory: #{@dir}" unless File.directory?(@dir)
    end
    
    def by_name(query)
      results = []
      pattern = %r{#{ query.strip.split('').map(&Regexp.method(:escape)) * '.*' }}i
      Find.find(@dir) do |path|
        next unless File.file?(path)
        path = path.sub(@dir + '/', '')
        results << path if path =~ pattern
      end
      results.sort
    end
    
    def by_content(query)
      `grep -rin #{@dir} -e "#{query}"`.split("\n").map { |result|
        parts = result.split(':')
        [parts[0].sub(@dir + '/', ''), parts[1].to_i, parts[2..-1] * ':']
      }.sort do |a,b|
        name, line = (a[0] <=> b[0]), (a[1] <=> b[1])
        name.zero? ? line : name
      end
    end
    
  end
end

