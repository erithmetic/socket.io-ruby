require 'socket.io/websocket/carrier_wave'
require 'socket.io/websocket/receiver'
require 'socket.io/websocket/sender'

module SocketIo
  module Websocket
    include CarrierWave
    include Receiver
    include Sender

    @@events = {}

    def self.included(target)
      target.transport = :websocket
      target.on_start :init_session
      target.on_data :handle_packet

      target.extend ClassMethods

      @@events[target] = {}
    end

    def events
      @@events[self.class]
    end

    module ClassMethods
      def events
        Websocket.class_variable_get(:@@events)[self]
      end

      def on(event, method)
        events[event.to_s] = method
      end
    end
  end
end
