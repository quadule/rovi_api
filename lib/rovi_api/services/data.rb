module RoviAPI
  module Services
    class Data < Service
      def get(endpoint, method, params={})
        @client.get(:data, :"v1.1", endpoint, method, params)
      end

      def album
        @album ||= Endpoints::Album.new(self)
      end

      def name
        @name ||= Endpoints::Name.new(self)
      end

      def song
        @song ||= Endpoints::Song.new(self)
      end
    end
  end
end
