module RoviAPI
  module Endpoints
    class Album < Endpoint
      def get(method, params={})
        @service.get(:album, method, params)
      end

      def info(params={})
        get(:info, params).album
      end
    end
  end
end
