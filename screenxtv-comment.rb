#! /usr/bin/env ruby
# -*- coding: utf-8 -*-
require "SocketIO"
require "readline"
require "curses"


Curses.init_screen
Curses.start_color
Curses.init_pair 1, Curses::COLOR_YELLOW, Curses::COLOR_BLACK
Curses.init_pair 2, Curses::COLOR_BLACK, Curses::COLOR_RED

$messages=[]
$title="ScreenX.tv Comment Viewer".center(Curses.cols)
$status="".center(Curses.cols, "*")

def comment(data)
  data.each do |d|
    message ="#{d["name"]} : #{d["message"]}"
    mes message
  end
end

def viewer(data)
  data.each do |d|
    $status="( #aki017 #{d["viewer"]} / #{d["total_viewer"]} )".rjust(Curses.cols, "*")
    # Curses.addstr message
    draw
  end
end

def mes(data, time=Time.now)
  $messages << {"text"=>data, "time"=>time}
  draw
end

def draw
  l = $messages.size
  lines = Curses.lines
  cols = Curses.cols
  pdata = (l > lines - 3)? $messages[l-lines+3, l] : $messages

  Curses.clear
  pdata.each_with_index do |i, count|
    Curses.setpos count+1, 0
    Curses.addstr "#{i["text"]}"
    Curses.setpos count+1, cols-10
    Curses.addstr i["time"].strftime("< %H:%M:%S")
  end
  Curses.setpos 0, 0
  Curses.addstr $title
  Curses.setpos Curses.lines()-2, 0
  Curses.addstr $status
  Curses.setpos Curses.lines()-1, 0
  Curses.refresh
end
  uri = URI("http://screenx.tv")
  uri.port = 8800
  client = SocketIO.connect( uri, sync: true) do
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
begin
  draw
  loop do
    system "stty echo"
    mes Readline.readline("test : ")
    system "stty -echo"
  end
ensure
  Curses.close_screen
end

