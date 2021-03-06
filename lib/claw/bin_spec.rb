Claw::BIN_SPEC = Oyster.spec do
  name "claw -- search and open files"
  author "James Coglan <jcoglan@googlemail.com>"
  
  synopsis "claw DIRECTORY -c EDITOR"
  
  description <<-EOS
    claw gives you a handy way to search your filesystem and open files using
    any program you like. I wrote it to help me edit large projects in gEdit,
    but you can use it for other things too, including opening files in a browser
    or running them using your testing tools.
    
    To start a claw session, we need the directory to search and a command to
    open files with. Some examples:
    
      claw . -c gedit
      claw features -c cucumber
      claw public -c firefox
    
    This starts a terminal session that provides commands for querying the
    filesystem in the directory you've chosen. Commands begin with a colon
    followed by a single letter and any arguments the command expects.
    
    Commands are:
    
      :f -- searches by filename, using a fuzzy match on each
            file's basename.
      
      :t -- searches by text by shelling out to `grep` and using
            the supplied pattern to find matching files.
      
      :c -- changes the command, e.g. ":c firefox" tells claw to
            use Firefox to open files you select.
      
      :q -- quits claw, returning you to your shell.
    
    The search commands print lists of numbered search results; typing a number
    into the terminal opens the corresponding file from the most recent search
    using the current file-opening command.
  EOS
  
  string :command, :desc => "Command used to open files"
end

