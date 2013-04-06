#! /usr/bin/env ruby
# -*- coding: utf-8 -*-
require "SocketIO"

puts "ScreenX.tv Comment Viewer"
uri = URI("http://screenx.tv")
uri.port = 8800

client = SocketIO.connect( uri) do
  before_start do
    on_message {|message| puts message}
    on_event('chat'){ |data| p data}
    on_event('viewer'){ |data| p data}
    on_disconnect {puts "I GOT A DISCONNECT"}
  end

  after_start do
    emit("init", {channel: 'aki017'})
  end
end
loop do
  sleep 10
end
