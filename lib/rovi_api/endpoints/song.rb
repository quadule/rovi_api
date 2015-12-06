module RoviAPI
  module Endpoints
    class Song < Endpoint
      def get(method, params={})
        @service.get(:song, method, params)
      end

      def info(params={})
        get(:info, params).song
      end
    end
  end
end
