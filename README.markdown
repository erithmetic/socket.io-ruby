# socket.io-ruby

Socket.io server plugin for Cramp.

## Usage

This implementation Socket.io works within an existing [cramp](http://cramp.in/) app. 
Cramp is similar in spirit to Rails but specializes in evented web apps. Simply 
`gem install cramp` and run `cramp new myapp`.

Define a new Cramp::Action and include SocketIo::Websocket. Then define which 
method should handle certain events and messages.

    # app/actions/socket_action.rb
    
    class SocketAction < Cramp::Websocket
      include SocketIo::Websocket

      on :message, :read_message
      on :trap, :report_trap
      
      # This is fired when the client sends a standard 
      # Socket.io message
      def read_message(data)
        puts "Our Bothan spies report #{data}"
      end
      
      def report_trap(imperial_fleet)
        puts "It's a trap!"
        puts "Concentrate all firepower on #{imperial_fleet[:super_stardestroyer]}"
      end
    end

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Derek Kastner. See LICENSE for details.
