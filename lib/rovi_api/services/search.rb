module RoviAPI
  module Services
    class Search < Service
      def get(endpoint, method, params={})
        @client.get(:search, :"v2.1", endpoint, method, params)
      end

      def music
        @music ||= Endpoints::Music.new(self)
      end
    end
  end
end
