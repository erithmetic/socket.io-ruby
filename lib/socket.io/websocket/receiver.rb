require 'socket.io/packet'

module SocketIo
  module Websocket
    module Receiver
      def handle_packet(data)
        packet = SocketIo::Packet.parse(data)

        case packet.class.to_s
        when 'SocketIo::Packet::DisconnectPacket' then
          self.channel_id = nil
        when 'SocketIo::Packet::HeartbeatPacket' then
          self.channel_id = Time.now
        when 'SocketIo::Packet::MessagePacket' then
          handle_message(packet)
        when 'SocketIo::Packet::JsonPacket' then
          handle_json(packet)
        when 'SocketIo::Packet::EventPacket' then
          handle_event(packet)
        when 'SocketIo::Packet::AckPacket' then
        when 'SocketIo::Packet::ErrorPacket' then
        when 'SocketIo::Packet::NoopPacket' then
        end
      end

      def handle_message(packet)
        ack_args = send events['message'], packet.data
        ack packet, args: ack_args
      end

      def handle_json(packet)
        ack_args = send events['message'], packet.json
        ack packet, args: ack_args
      end

      def handle_event(packet)
        json = packet.json
        name = json['name']
        ack_args = send events[name].to_s, *json['args']
        ack packet, args: ack_args
      end

      def handle_error(packet)
        puts "Error from client: #{packet.inspect}"
      end
    end
  end
end
