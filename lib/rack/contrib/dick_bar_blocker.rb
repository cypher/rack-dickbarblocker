module Rack
  module Contrib
    class DickBarBlocker
      def initialize(app, name = nil,  &block)
        raise ArgumentError, "You need to supply a name or a block" if name.nil? and block.nil?

        @app = app
        @name = name
        @block = block
      end

      def call(env)
        referrer = env['HTTP_REFERER']
        # Regex courtesy of John Gruber: http://daringfireball.net/2009/04/how_to_block_the_diggbar
        if referrer && referrer =~ %r{http://(?:www\.)?digg.com/\w{1,8}/*(\?.*)?$}
          if @block
            body = @block.call.to_s
          else
            body = <<BODY
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html lang="en">
    <head>
      <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
      <title>Don't be a dick, say no to the DiggBar</title>
      <style type="text/css">
      body {
          font-family: "Lucida Grande";
          font-size: 12px;
          line-height: 1.8em;
          /* So it doesn't stick to the top of the page */
          margin-top: 12em;
      }
      /* I am no CSS master, but this seems to center the text on the page */
      p {
          margin-left: auto;
          margin-right: auto;
          width: 32em;
      }
      </style>
    </head>
    <body>
        <p>
            Dear Digg,<br>
            Framing sites is bullshit.<br>
            <br>
            Your pal,<br>
            —#{@name}
        </p>
        <p>
            p.s. Firefox users may enjoy the<br>
            <a href='http://userscripts.org/scripts/show/45795'>DiggBar Killer script for Greasemonkey</a>.
        </p>
        <p>
            p.p.s. Digg users can disable the DiggBar under<br>
            My Profile → Settings → <a href='http://digg.com/settings/viewing'>Viewing Preferences</a>.
        </p>
    </body>
</html>
BODY
          end

          [200, {'Content-Length' => body.size.to_s, 'Content-Type' => 'text/html'}, body]
        else
          @app.call(env)
        end
      end
    end
  end
end
