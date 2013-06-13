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
require "RyanCom/Output"
require "RyanCom/Utils"
require "RyanCom/Comment"

class String
  def ljust(width, padding=' ')
    padding_size = [0, width - size].max
    self + padding * padding_size
  end
  def rjust(width, padding=' ')
    padding_size = [0, width - size].max
    padding * padding_size + self
  end
  def center(width, padding=' ')
    padding_size = [0, width - size].max
    padding * ( padding_size / 2 ) + self + padding * ( ( padding_size + 1 ) / 2 )
  end

  def size
    each_char.map{|c| c.bytesize == 1 ? 1 : 2}.reduce(0, &:+)
  end
end
 
channel = nil; 
OptionParser.new do |opt|
  opt.on('--channel [VALUE]',"set channel") do |v|
    channel = v
  end
  opt.parse!(ARGV)
end

RyanCom.start channel
