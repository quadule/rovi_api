module RoviAPI
  module Endpoints
    class Name < Endpoint
      def get(method, params={})
        @service.get(:name, method, params)
      end

      def info(params={})
        get(:info, params).name
      end
    end
  end
end
