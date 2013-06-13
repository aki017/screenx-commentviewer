module RyanCom
  class Comment
    attr_accessor :name, :message, :time
  
    def initialize(name, message, time=Time.now)
      @name = name || "NoName"; @message = message || "nil"; @time = time
    end

    def write
      # system "say '#{message}'&"
      cols = RyanCom::detect_terminal_size()[0]
      rtn = "\e[0G\e[K" 
      rtn << name.ljust(10)
      rtn << ": "
      rtn << message
      rtn << time.strftime("< %H:%M:%S").rjust(cols - 10 - 2 - message.size())
      rtn
    end
  end
end
