require 'test/spec'
require 'rack/mock'
require 'rack/contrib/digg_bar_blocker'

context "Rack::Contrib::DiggBarBlocker" do
  app = lambda {|env| [200, {'Content-Type' => 'text/plain'}, "Hello, kitty"]}

  context "non-digg-toolbar referrer" do
    specify "returns unmodified response" do
      status, headers, body = Rack::Contrib::DiggBarBlocker.new(app).call({'HTTP_REFERER' => 'http://daringfireball.net'})

      status.should.equal 200
      headers['Content-Type'].should.equal 'text/plain'
      body.should.equal "Hello, kitty"
    end
  end

  context "via digg bar" do
    specify "return anti-digg-toolbar site" do
      status, headers, body = Rack::Contrib::DiggBarBlocker.new(app).call({'HTTP_REFERER' => 'http://digg.com/d1oNOZ'})

      status.should.equal 200
      headers['Content-Type'].should.equal 'text/html'
      body.should =~ %r{<title>Say no to the DiggBar</title>}
      body.should =~ %r{Dear Digg.*Framing Sites is bullshit\.}m
    end
  end
end
