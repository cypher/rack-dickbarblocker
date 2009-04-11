module Rack
  module Contrib
    class NoDouchebaggery
      def initialize(app)
        @app = app
      end

      def call(env)
        referrer = env['HTTP_REFERER']
        # Regex courtesy of John Gruber: http://daringfireball.net/2009/04/how_to_block_the_diggbar
        if referrer && referrer =~ %r{http://digg.com/\w{1,8}/*(\?.*)?$}
          body = <<BODY
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Say no to the DiggBar</title>
  </head>
  <body>
    Dear Digg<br />
    Framing Sites is bullshit.<br />
  </body>
</html>
BODY

          [200, {'Content-Length' => body.size.to_s, 'Content-Type' => 'text/html'}, body]
        else
          @app.call(env)
        end
      end
    end
  end
end
