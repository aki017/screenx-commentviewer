#! /usr/bin/env ruby
# -*- coding: utf-8 -*-
require "SocketIO"

puts "ScreenX.tv Comment Viewer"
uri = URI("http://screenx.tv")
uri.port = 8800

def comment(data)
  data.each do |d|
    message ="#{d["name"]} : #{d["message"]}"
    puts message
  end
end

def viewer(data)
  data.each do |d|
    message ="現在の視聴者 : #{d["viewer"]} / #{d["total_viewer"]}"
    puts message
  end
end
client = SocketIO.connect( uri) do
  before_start do
    on_message {|message| puts message}
    on_event('chat'){ |data| comment data}
    on_event('viewer'){ |data| viewer data}
    on_disconnect {puts "I GOT A DISCONNECT"}
  end

  after_start do
    emit("init", {channel: 'aki017'})
  end
end
loop do
  sleep 10
end
