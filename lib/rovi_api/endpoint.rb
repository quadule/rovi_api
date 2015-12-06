module RoviAPI
  class Endpoint
    attr_reader :service

    def initialize(service)
      @service = service
    end
  end
end
