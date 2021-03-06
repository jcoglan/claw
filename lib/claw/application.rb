module Claw
  class Application
    
    PROMPT = '> '
    SPACE  = ' '
    
    COMMANDS = {
      "f" => :search_by_filename,
      "t" => :search_by_content,
      "q" => :quit,
      "c" => :command=,
      "d" => :directory=,
      "a" => :open_all
    }
    
    def initialize(options, io)
      @dir     = File.expand_path(options[:unclaimed].first || '.')
      @io      = io
      @results = []
      @search  = Search.new(@dir)
      @options = options
      @command = options[:command]
    end
    
    def prompt
      PROMPT
    end
    
    def interpret(command)
      Readline::HISTORY << command
      args = command.strip.split(/\s+/)
      return if dispatch_command(args.first, args[1..-1])
      open(args[0])
    rescue StandardError => e
      @io.puts "Error: #{e.message}"
    end
    
  private
    
    def dispatch_command(command, args)
      return false unless command =~ /^:/
      method = COMMANDS[command.sub(':', '')]
      raise Claw::Error.new("Unknown command #{command}") unless method
      __send__(method, *args)
      true
    end
    
    def open(index)
      return unless Numeric === index or index =~ /^\d+$/
      return unless defined?(@command)
      path = @results[index.to_i - 1]
      return unless path
      output = `#{ @command } #{ path }`
      @io.puts output if output and output != ''
    end
    
    def open_all
      (1..@results.size).each(&method(:open))
    end
    
    def command=(app)
      @command = app
    end
    
    def directory=(dir)
      dir = File.join(@dir, dir)
      @search = Search.new(dir)
    end
    
    def search_by_filename(*query)
      @results = @search.by_name(query * SPACE)
      print_results
    end
    
    def search_by_content(*query)
      @results = @search.by_content(query * SPACE).map { |r| r.first }.uniq
      print_results
    end
    
    def quit
      exit
    end
    
    def print_results
      @io.puts ""
      @results.each_with_index do |result, i|
        @io.puts sprintf('% 4d', i+1) + ': ' + result.gsub(@search.dir + '/', '')
      end
      @io.puts ""
    end
    
  end
end

