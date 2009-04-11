require 'test/spec'
require 'rack/mock'
require 'rack/contrib/dick_bar_blocker'

context "Rack::Contrib::DickBarBlocker" do
  app = lambda {|env| [200, {'Content-Type' => 'text/plain'}, "Hello, kitty"]}

  context "non-digg-toolbar referrer" do
    specify "returns unmodified response" do
      status, headers, body = Rack::Contrib::DickBarBlocker.new(app).call({'HTTP_REFERER' => 'http://daringfireball.net'})

      status.should.equal 200
      headers['Content-Type'].should.equal 'text/plain'
      body.should.equal "Hello, kitty"
    end
  end

  context "via digg bar" do
    specify "return anti-digg-toolbar site" do
      status, headers, body = Rack::Contrib::DickBarBlocker.new(app).call({'HTTP_REFERER' => 'http://digg.com/d1oNOZ'})

      status.should.equal 200
      headers['Content-Type'].should.equal 'text/html'
      body.should =~ %r{<title>Don't be a dick, say no to the DiggBar</title>}i
      body.should =~ %r{Dear Digg,.*Framing sites is bullshit\.}mi
    end
  end
end
