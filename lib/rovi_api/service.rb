module RoviAPI
  class Service
    attr_reader :client

    def initialize(client)
      @client = client
    end
  end
end
