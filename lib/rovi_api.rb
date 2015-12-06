require "faraday"
require "faraday_middleware"

require_relative "rovi_api/client"
require_relative "rovi_api/endpoint"
require_relative "rovi_api/service"
require_relative "rovi_api/version"
require_relative "rovi_api/endpoints/album"
require_relative "rovi_api/endpoints/music"
require_relative "rovi_api/endpoints/name"
require_relative "rovi_api/endpoints/song"
require_relative "rovi_api/services/data"
require_relative "rovi_api/services/search"

module RoviAPI
  class << self
    attr_accessor :host, :key, :secret
  end

  self.host   = ENV["ROVI_API_HOST"] || "http://api.rovicorp.com"
  self.key    = ENV["ROVI_API_KEY"]
  self.secret = ENV["ROVI_API_SECRET"]

  def self.client
    raise "RoviAPI.key and RoviAPI.secret must be set" unless key && secret
    @client ||= Client.new
  end

  def self.connection
    Faraday.new(host) do |c|
      c.adapter Faraday.default_adapter
      c.headers["Accept"] = "application/json"
      c.response :rashify
      c.response :raise_error
      c.response :json, content_type: /\bjson$/
    end
  end
end
