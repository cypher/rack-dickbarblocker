# rack-dickbarblocker

A Rack middleware that displays a special page when the DiggBar is used.

Hat-tip to [rue](http://github.com/rue) for suggesting the name.

# Usage

* Install it via Rubygems:

        # Add http://gems.github.com to your gem sources.
        # (You only need to do this once)
        gem sources -a http://gems.github.com
        # Install the gem
        sudo gem install cypher-rack-dickbarblocker

* Add this to your rack config:

        require 'rack/contrib/dick_bar_blocker'
        
        use Rack::Contrib::DickBarBlocker

* Or, if you're on Rails, add this to your environment.rb:

        require 'rack/contrib/dick_bar_blocker'
        
        Rails::Initializer.run do |config|
          config.gem 'cypher-rack-dickbarblocker', :lib => 'rack/contrib/dick_bar_blocker', :source => 'http://gems.github.com'
          config.middleware.use 'Rack::Contrib::DickBarBlocker'
          
          # rest of your config
        end

By default, it shows the following text (sans markup):

> Dear Digg,
> Framing sites is bullshit.
>
> Your pal,
> —J.G.
>
> p.s. Firefox users may enjoy the<br>
> DiggBar Killer script for Greasemonkey.
>
> p.p.s. Digg users can disable the DiggBar under
> My Profile → Settings → Viewing Preferences.

You can override this by supplying the middleware with a block that returns whatever you want it to display:

    use Rack::Contrib::DickBarBlocker do
      <<-HTML
      <html>
        <body>
          Kittens are fun!
        </body>
      </html>
      HTML
    end

This would return an HTML page with "Kittens are fun!" on it instead.

DickBarBlocker expects the return value of the body to respond to `to_s`.
It also currently hardcodes the content type to `text/html`, so your response should
be HTML.

## Copyright

Copyright (c) 2009 Markus Prinz. See COPYING for details.
