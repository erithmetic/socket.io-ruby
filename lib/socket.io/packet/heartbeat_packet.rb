module SocketIo
  class Packet
    class HeartbeatPacket < Packet
      def type_id; 2; end
    end
  end
end
