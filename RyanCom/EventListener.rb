module RyanCom
  module EventListener
    def listeners
      @listeners ||= {}
    end
    def addListener(k,&block)
      listeners[k]||=[]
      listeners[k] << block
    end

    def dispatchEvent(k,*args)
      listeners[k].each{|l|
        l.call(args)
      }
    end
  end

  extend EventListener
end
