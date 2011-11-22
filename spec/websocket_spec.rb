require 'spec_helper'
require 'socket.io/websocket'

describe SocketIo::Websocket do
  class SocketAction
    def self.transport=(val); end
    def self.on_start(val); end
    def self.on_data(val); end
    include SocketIo::Websocket
  end

  describe '.included' do
    it 'initializes an `events` class variable' do
      SocketAction.events.should == {}
    end
  end

  describe '.on' do
    it 'stores a callback for the specified event' do
      SocketAction.on(:melody, :play_riff)
      SocketAction.events['melody'].should == :play_riff
    end
  end
end
