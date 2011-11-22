module SocketIo
  class Packet
    class NoopPacket < Packet
      def type_id; 8; end
    end
  end
end
