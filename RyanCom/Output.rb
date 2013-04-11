module RyanCom
  module Output
    def write ( args, options={} )
      up = options[:line] || 1;
      refresh = options[:refresh].nil? ? true : options[:refresh];
      print "\e[#{up}F\e[#{up}M"
      puts args.write
      write_status
      Readline.refresh_line if refresh
    end

    def write_status(str=@status)
      print "\e[48;5;253m"
      print "\e[38;5;232m"
      print str.rjust(detect_terminal_size[0])
      print "\e[0m\n"
    end
  end
  extend Output
end
