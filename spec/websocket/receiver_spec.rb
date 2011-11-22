require 'spec_helper'
require 'socket.io/websocket'
require 'socket.io/websocket/receiver'
require 'json'

describe SocketIo::Websocket::Receiver do
  class MyAction
    def self.transport=(val); end
    def self.on_start(val); end
    def self.on_data(val); end
    include SocketIo::Websocket

    on :quux, :qat

    def qat(one, two); end
  end

  let(:data) do
    { 'name' => 'quux', 'args' => ['hi', 5] }.to_json
  end

  describe '#handle_packet' do
    it 'handles an event packet' do
      packet = SocketIo::Packet::EventPacket.new :data => data
      SocketIo::Packet.stub!(:parse).and_return(packet)

      action = MyAction.new
      action.should_receive(:handle_event).with(packet)
      action.handle_packet ''
    end
  end

  describe '#handle_event' do
    it 'fires the specified event callback' do
      packet = SocketIo::Packet::EventPacket.new :data => data

      action = MyAction.new
      action.should_receive(:qat).with('hi',5).once
      action.stub! :ack
      action.handle_event packet
    end
  end
end
