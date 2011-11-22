require 'json'

module SocketIo
  class Packet
    attr_accessor :data, :id, :ack, :type_id, :endpoint

    PACKET_REGEX = /([^:]+):([0-9]+)?(\+)?:([^:]+)?:?([\s\S]*)?/

    PACKET_TYPES = [:disconnect, :connect, :heartbeat, :message, :json, :event, :ack, :error, :noop]
    PACKET_TYPES.each do |type|
      require "socket.io/packet/#{type}_packet"
    end

    def self.parse(string)
      pieces = string.match(PACKET_REGEX);
      return nil if pieces.nil?

      type = PACKET_TYPES[pieces[1].to_i]
      packet_class = self.const_get "#{type.capitalize}Packet"

      packet = packet_class.new :id => pieces[2] || '',
        :ack => pieces[3] ? 'data' : true,
        :data => pieces[5] || '',
        :endpoint => pieces[4] || ''

      packet.parse_pieces pieces if packet.respond_to?(:parse_pieces)
      packet
    end

    def self.parse_json(str)
      JSON.parse str
    rescue
      false
    end

    def initialize(options = {})
      options.each do |name, value|
        self.send "#{name}=", value
      end
    end

    def json
      @json ||= self.class.parse_json(data)
    end

    def ackdata?
      ack == 'data'
    end

    def to_s(payload = nil)
      parts = []
      parts << type_id
      parts << (id || '') + (ack == 'data' ? '+' : '') 
      parts << endpoint
      parts << payload if payload
      parts.join ':'
    end
  end
end
