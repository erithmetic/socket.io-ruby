require 'json'

module SocketIo
  class Packet
    class AckPacket < Packet
      attr_accessor :ack_id, :args

      def parse_pieces(pieces)
        if sub_pieces = data =~ /^([0-9]+)(\+)?(.*)/
          self.ack_id = sub_pieces[1];
          self.args = [];

          if sub_pieces[3]
            self.args = Packet.parse_json(sub_pieces[3]) || [];
          end
        end
      end

      def type_id; 6; end

      def to_s
        payload = ack_id.to_s
        payload += '+' + args.to_json if args
        super payload
      end
    end
  end
end
