module SocketIo
  class Packet
    class JsonPacket < Packet
      def type_id; 4; end

      def to_s
        super json
      end
    end
  end
end
