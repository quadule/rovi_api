module RoviAPI
  class Client
    attr_reader :connection, :last_response

    def initialize(key: RoviAPI.key, secret: RoviAPI.secret, connection: RoviAPI.connection)
      @key = key or raise ArgumentError("missing key")
      @secret = secret or raise ArgumentError("missing secret")
      @connection = connection
    end

    def data
      @data ||= Services::Data.new(self)
    end

    def search
      @search ||= Services::Search.new(self)
    end

    def get(service, version, endpoint, method, params={})
      path = [service, version, endpoint, method].join("/")
      begin
        @last_response = @connection.get(path, default_params.merge(params))
      rescue ::Faraday::ClientError => ex
        @last_response = ex.response
        raise
      end
      @last_response.body
    end

    def default_params
      { apikey: @key, sig: signature }
    end

    def signature
      Digest::MD5.hexdigest(@key + @secret + Time.now.to_i.to_s)
    end

    def inspect
      "<#{self.class} @key=#{@key.inspect}>"
    end
  end
end
