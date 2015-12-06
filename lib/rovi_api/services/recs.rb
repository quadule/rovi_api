module RoviAPI
  module Services
    class Recs < Service
      def get(endpoint, method, params={})
        @client.get(:recs, :"v2.1", endpoint, method, params)
      end
    end
  end
end
