require 'json'

module SocketIo
  class Packet
    class EventPacket < Packet
      def name
        json['name']
      end

      def args
        json['args'] || []
      end

      def type_id; 5; end

      def to_s
        ev = { 'name' => name }

        if args && args.length
          ev['args'] = args
        end

        super ev.to_json;
      end
    end
  end
end
