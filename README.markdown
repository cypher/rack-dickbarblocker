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


## Copyright

Copyright (c) 2009 Markus Prinz. See COPYING for details.
