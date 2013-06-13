require 'ruby-growl'

module RyanCom
  module Notify
    def notify(text)
      app_name = 'screenxtv'
 
      growl = Growl.new 'localhost',app_name
      growl.add_notification app_name
      growl.notify app_name, 'screenxtv', text
    end
  end

  init do
    addListener "comment" do |args|
      data = args.first
      message = "#{data["name"]} : #{data["message"]}"
      notify message
    end

    addListener "viewer" do |args|
      data = args.first
      message = "viewer #{data["viewer"]} / #{data["max_viewer"]}"
      notify message
    end
  end

  extend Notify
end
