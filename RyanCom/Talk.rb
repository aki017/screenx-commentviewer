require 'open3'
module RyanCom
  module Talk
    def say(text)
      c = "echo"
      if command_exists? "saykana"
        c = "saykana"
      else command_exists? "say"
        c = "say"
      end
      Open3.popen3 c, text
    end

  end

  init do
    addListener "comment" do |d|
      data=d.first
      message = data["message"]
      say message
    end

    addListener "viewer" do |data|
      message = "#{data["viewer"]}人が見てます"
      say message
    end
  end

  extend Talk
end
