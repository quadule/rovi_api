require "fuzzy_match"

module RoviAPI
  module Endpoints
    class Music < Endpoint
      def get(method, params={})
        @service.get(:music, method, params)
      end

      def find(member, query, params={})
        results = search(params.merge(query: query)).map(&member)
        return [] if results.empty?

        match_key = results[0].has_key?("title") ? :title : :name
        matcher = FuzzyMatch.new(results, read: match_key, must_match_at_least_one_word: true)
        result = matcher.find(query)

        if result
          results.unshift(results.delete(result))
        else
          []
        end
      end

      def search(params={})
        get(:search, params).search_response.results || []
      end

      def album(query, params={})
        find(:album, query, params.merge(entitytype: "album"))
      end

      def artist(query, params={})
        find(:name, query, params.merge(entitytype: "artist"))
      end

      def song(query, params={})
        find(:song, query, params.merge(entitytype: "song"))
      end
    end
  end
end
