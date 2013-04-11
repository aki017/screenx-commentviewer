module RyanCom
  module Utils
    def detect_terminal_size
      begin
        tiocgwinsz = 0x40087468
        data = [0, 0, 0, 0].pack("SSSS")
        if STDOUT.ioctl(tiocgwinsz, data) >= 0 then
          rows, cols= data.unpack("SSSS")[0, 2]
          if cols >= 0 then [cols, rows] else raise NotImplementedError end
        else
          raise NotImplementedError
        end
      rescue Exception
        if (ENV['COLUMNS'] =~ /^\d+$/) && (ENV['LINES'] =~ /^\d+$/)
          [ENV['COLUMNS'].to_i, ENV['LINES'].to_i]
        elsif (RUBY_PLATFORM =~ /java/ || (!STDIN.tty? && ENV['TERM'])) && command_exists?('tput')
          [`tput cols`.to_i, `tput lines`.to_i]
        elsif STDIN.tty? && command_exists?('stty')
          `stty size`.scan(/\d+/).map { |s| s.to_i }.reverse
        else
          [80, 24]
        end
      rescue
        [80, 24]
      end
    end
  end

  extend Utils
end

