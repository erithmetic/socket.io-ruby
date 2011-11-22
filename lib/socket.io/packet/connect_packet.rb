module SocketIo
  class Packet
    class ConnectPacket < Packet
      def qs
        data
      end

      def type_id; 1; end

      def to_s
        super(qs)
      end
    end
  end
end
