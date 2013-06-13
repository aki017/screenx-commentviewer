#! /usr/bin/env ruby
# -*- coding: utf-8 -*-
#
require 'rubygems'
require 'bundler/setup'
require "SocketIO"
require "readline"
require 'optparse'
$:.unshift File.dirname(__FILE__)
require "RyanCom/Core"
require "RyanCom/EventListener"
require "RyanCom/Talk"
require "RyanCom/Output"
require "RyanCom/Utils"
require "RyanCom/Comment"
require "RyanCom/Notify"
require "RyanCom/ScreenX"
 
channel = nil; 
OptionParser.new do |opt|
  opt.on('--channel [VALUE]',"set channel") do |v|
    channel = v
  end
  opt.parse!(ARGV)
end

RyanCom.start channel
