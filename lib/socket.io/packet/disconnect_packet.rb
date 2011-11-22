module SocketIo
  class Packet
    class DisconnectPacket < Packet
      def type_id; 0; end
    end
  end
end
