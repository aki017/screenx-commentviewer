module RyanCom
  module Talk
    def say(text)
      if command_exists? "saykana"
        `saykana #{text} 2&>1 >/dev/null &`
      else command_exists? "say"
        `say #{text} 2&>1 >/dev/null &`
      end
    end

  end

  init do
    addListener "comment" do |args|
      data = args.first
      message = data["message"]
      say message
    end

    addListener "viewer" do |args|
      data = args.first
      message = "#{data["viewer"]}人が見てます"
      say message
    end
  end

  extend Talk
end
