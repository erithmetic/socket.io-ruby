# socket.io-ruby

*NOTICE* This project is no longer maintained. I will accept tested pull requests, but that's it!

[Socket.io] for the Ruby Kids. A plugin for [Cramp](http://cramp.in/). Socket.io is a library that makes writing cross-borwser websockets super easy and resilient.

## Usage

This implementation Socket.io works within an existing [cramp](http://cramp.in/) app. 
Cramp is similar in spirit to Rails but specializes in evented web apps. Simply 
`gem install cramp` and run `cramp new myapp`.

Define a new Cramp::Action and include SocketIo::Websocket. Then define which 
method should handle certain events and messages.

    # app/actions/akbar_action.rb
    
    class AkbarAction < Cramp::Websocket
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
        puts "Concentrate all firepower on #{imperial_fleet['super_stardestroyer']}"
        return { 'move' => 'sector 227' }
      end
    end

By default, Cramp uses HttpRouter in config/routes.rb to manage connections. SocketIo has a handy helper for that:

    # config/routes.rb
    
    require 'socket.io'
    require 'http_router'
    
    HttpRouter.new do
      SocketIo.routes self, AkbarAction
    end

Optionally, SocketIo.routes can take a path. The default is `/socket.io`.

Throw that in with some [Thin](http://code.macournoyer.com/thin/) or [Rainbows](http://rainbows.rubyforge.org), and you've got yourself a websocket server!

Note that you'll need to configure cramp's websocket adapter to use thin or rainbows:

    # config.ru
    
    Cramp::Websocket.backend = :rainbows  # or :thin

Here's the client-side code to make it all happen:

    <script type="text/javascript" src="socket.io-client.js"></script>
    <script type="text/javascript">
      var socket = io.connect('http://localhost/socket.io');
      socket.on('connect', function () {
        socket.send('the Emperor is building a new Death Star');
        socket.emit('trap', { 'super_stardestroyer': 'Executor' }, function(instructions) {
          alert('moving to ' + instructions['move']);
        });
      });
    </script>

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
