require 'test/spec'
require 'rack/mock'
require 'rack/contrib/dick_bar_blocker'

context "Rack::Contrib::DickBarBlocker" do
  app = lambda {|env| [200, {'Content-Type' => 'text/plain'}, "Hello, kitty"]}

  context "non-digg-toolbar referrer" do
    specify "returns unmodified response" do
      status, headers, body = Rack::Contrib::DickBarBlocker.new(app, 'J.G.').call({'HTTP_REFERER' => 'http://daringfireball.net'})

      status.should.equal 200
      headers['Content-Type'].should.equal 'text/plain'
      body.should.equal "Hello, kitty"
    end
  end

  context "via digg bar" do
    specify "return anti-digg-toolbar site" do
      status, headers, body = Rack::Contrib::DickBarBlocker.new(app, 'J.G.').call({'HTTP_REFERER' => 'http://digg.com/d1oNOZ'})

      status.should.equal 200
      headers['Content-Type'].should.equal 'text/html'
      body.should =~ %r{<title>Don't be a dick, say no to the DiggBar</title>}i
      body.should =~ %r{Dear Digg,<br>\s+Framing sites is bullshit\.<br>\s+<br>\s+Your pal,<br>\s+—J.G.}mi
    end

    specify "works also with a www.digg.com referrer" do
      status, headers, body = Rack::Contrib::DickBarBlocker.new(app, 'J.G.').call({'HTTP_REFERER' => 'http://www.digg.com/d1oNOZ'})

      status.should.equal 200
      headers['Content-Type'].should.equal 'text/html'
      body.should =~ %r{<title>Don't be a dick, say no to the DiggBar</title>}i
      body.should =~ %r{Dear Digg,<br>\s+Framing sites is bullshit\.<br>\s+<br>\s+Your pal,<br>\s+—J.G.}mi
    end

    specify "uses the given name" do
      name = "test name"
      status, headers, body = Rack::Contrib::DickBarBlocker.new(app, name).call({'HTTP_REFERER' => 'http://digg.com/d1oNOZ'})

      status.should.equal 200
      headers['Content-Type'].should.equal 'text/html'
      body.should =~ %r{Your pal,<br>\s+—#{name}}i
    end

    specify "raises an error when no name or block is supplied" do
      lambda {
        Rack::Contrib::DickBarBlocker.new(app).call({'HTTP_REFERER' => 'http://digg.com/d1oNOZ'})
      }.should.raise ArgumentError
    end

    specify "returns custom content when supplied with a block" do
      block = lambda { "Here be kittens." }
      status, headers, body = Rack::Contrib::DickBarBlocker.new(app, &block).call({'HTTP_REFERER' => 'http://digg.com/d1oNOZ'})

      status.should.equal 200
      headers['Content-Type'].should.equal 'text/html'
      body.should.equal "Here be kittens."
    end
  end
end
