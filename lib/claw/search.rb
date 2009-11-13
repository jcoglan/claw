module Claw
  class Search
    
    EXCLUDED = %w[.git .svn CVS]
    
    attr_reader :dir
    
    def initialize(dir)
      @dir = File.expand_path(dir)
      raise Claw::Error.new("Not a directory: #{@dir}") unless File.directory?(@dir)
    end
    
    def by_name(query)
      results = []
      pattern = %r{#{ query.strip.split('').map(&Regexp.method(:escape)) * '.*' }}i
      Find.find(@dir) do |path|
        Find.prune if File.directory?(path) and EXCLUDED.include?(File.basename(path))
        next unless File.file?(path)
        results << path if File.basename(path) =~ pattern
      end
      results.sort
    end
    
    def by_content(query)
      results = []
      `grep -rin #{@dir} -e "#{query}"`.split("\n").each do |result|
        parts = result.split(':')
        path  = parts[0]
        next if path.split('/').any? { |p| EXCLUDED.include?(p) }
        line  = parts[1].to_i
        results << [path, line, (parts[2..-1] || []) * ':']
      end
      
      results.sort do |a,b|
        name, line = (a[0] <=> b[0]), (a[1] <=> b[1])
        name.zero? ? line : name
      end
    end
    
  end
end

