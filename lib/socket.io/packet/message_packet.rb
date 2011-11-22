module SocketIo
  class Packet
    class MessagePacket < Packet
      def type_id; 3; end

      def to_s
        super json
      end
    end
  end
end
