require 'socket.io/packet'

module SocketIo
  module Websocket
    module Sender
      Packet::PACKET_TYPES.each do |type|
        define_method "send_#{type}" do |*args|
          options = args[0] || {}
          klass = Packet.const_get("#{type.capitalize}Packet")
          packet = klass.new options
          str = packet.to_s
          render str
        end
      end

      def ack(calling_packet, options = {})
        ack_params = { ack_id: calling_packet.id }
        ack_params[:args] = options[:args] if calling_packet.ackdata?
        send_ack ack_params
      end
    end
  end
end
