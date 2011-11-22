module SocketIo
  class Packet
    class ErrorPacket < Packet
      REASONS = ['transport not supported', 'client not handshaken', 'unauthorized']
      ADVICE = %w{reconnect}

      def from_pieces(pieces)
        sub_pieces = data.split('+');
        self.reason = REASONS[sub_pieces[0]] || '';
        self.advice = ADVICE[sub_pieces[1]] || '';
      end

      def type_id; 7; end

      def to_s
        payload = nil
        if reason != '' || advice != ''
          payload = reason + (advice != '' ? ('+' + advice) : '')
        end
        super payload
      end
    end
  end
end
