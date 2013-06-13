require 'net/http'

module RyanCom
  module ScreenX
    def get_token_and_chats
      url = URI.parse("http://screenx.tv/#{@channel}")
      req = Net::HTTP::Get.new(url.path + "?chat")
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      lines = res.body.split("\n")
      csrf_token = lines.grep /<meta content="(.+)" name="csrf-token"/ do |arg|
        /content="(.+?)"/  =~ arg
        Regexp.last_match[1]
      end
      lines.grep /chats/ do |arg|
        chats = JSON.parse(arg[10..-2])
        chats = chats[-5..-1] if chats.length > 5
        chats.each {|o|
          comment [o]
        }
      end
      csrf_token
    end

    def post(message)
      Net::HTTP.post_form(URI.parse("http://screenx.tv/screens/post/#{@channel}"),{'authenticity_token'=>@token, "message"=>message})
    end
  end

  extend ScreenX
end
