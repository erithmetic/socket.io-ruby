require 'cramp'
require 'uuid'

class HandshakeAction < Cramp::Action
  HEARTBEAT_TIMEOUT = 27
  CLOSING_CONNECTION_TIMEOUT = 10
  #TRANSPORTS = 'websocket,xhr-polling,flashsocket'
  TRANSPORTS = 'websocket'

  def uuid
    @uuid ||= UUID.new
  end

  def session_id
    uuid.generate
  end

  def start
    body = [session_id, HEARTBEAT_TIMEOUT, CLOSING_CONNECTION_TIMEOUT, TRANSPORTS].join(':')
    render body
    finish
  end
end
