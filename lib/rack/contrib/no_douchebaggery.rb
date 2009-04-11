module Rack
  module Contrib
    class NoDouchebaggery
      def initialize(app)
        @app = app
      end

      def call(env)
        @app.call(env)
      end
    end
  end
end
