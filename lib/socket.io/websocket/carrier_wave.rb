module SocketIo
  module Websocket
    module CarrierWave
      @@cache = {}

      def init_session
        if session.nil?
          send_connect
          self.session = Time.now
        end
      end

      def session_id
        params[:session_id]
      end

      def session_key
        'sessions/' + session_id
      end
      def session
        @@cache[session_key]
      end
      def session=(cid)
        @@cache[session_key] = cid
      end
    end
  end
end
