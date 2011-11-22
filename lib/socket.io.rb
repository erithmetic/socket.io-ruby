require 'socket.io/packet'
require 'socket.io/websocket'
require 'socket.io/actions'

module SocketIo
  extend self

  def routes(router, handler, path = '/socket.io')
    router.add("#{path}/:protocol_version").to(HandshakeAction)
    router.add("#{path}/:protocol_version/websocket/:session_id").to(handler)
    #router.add("#{path}/:protocol_version/flashsocket/:session_id").to(ImpactAction)
    #router.add("#{path}/:protocol_version/xhr-polling/:session_id").to(ImpactXhrPollingAction)
    #router.add("#{path}/:protocol_version/xhr-polling/:session_id/:verified").to(ImpactXhrPollingAction)
    #router.add("#{path}/:protocol_version/xhr-polling/:session_id/send").to(ImpactXhrPollingAction)
  end
end

