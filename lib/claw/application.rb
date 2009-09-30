module Claw
  class Application
    
    PROMPT = '> '
    
    COMMANDS = {
      "f" => :search_by_filename,
      "t" => :search_by_content,
      "q" => :quit
    }
    
    def initialize(dir, options = {})
      @search = Search.new(dir)
      @options = options
      @command = options[:command]
    end
    
    def run!
      loop { interpret(Readline.readline(PROMPT)) }
    end
    
  private
    
    def interpret(command)
      Readline::HISTORY << command
      args = command.strip.split(/\s+/)
      return if dispatch_command(args.first, args[1..-1])
      open(args[0])
    end
    
    def dispatch_command(command, args)
      return false unless command =~ /^:/
      method = COMMANDS[command.sub(':', '')]
      raise "Unknown command #{command}" unless method
      __send__(method, *args)
      true
    end
    
    def open(index)
      return unless Numeric === index or index =~ /^\d+$/
      return unless defined?(@results) and defined?(@command)
      path = @results[index.to_i - 1]
      return unless path
      `#{ @command } #{ path }`
    end
    
    def search_by_filename(query)
      @results = @search.by_name(query)
      print_results
    end
    
    def search_by_content(query)
      @results = @search.by_content(query).map { |r| r.first }.uniq
      print_results
    end
    
    def quit
      exit
    end
    
    def print_results
      puts ""
      @results.each_with_index do |result, i|
        puts sprintf('% 4d', i+1) + ': ' + result
      end
      puts ""
    end
    
  end
end

