require "spec_helper"

describe RoviAPI::Endpoints::Music do
  let(:client) { RoviAPI::Client.new(connection: connection) }
  let(:connection) { double(:faraday) }
  let(:artist) { Hashie::Rash.new(name: "Artist Name") }
  before do
    allow(connection).to receive(:get).and_return(
      double(:response, body:
        Hashie::Rash.new(search_response: { results: [{ name: artist }] })
      )
    )
  end

  describe "#artist" do
    subject { client.search.music.artist("Artist Name") }

    before do
      expect(connection).to receive(:get)
        .with("search/v2.1/music/search", hash_including(query: "Artist Name", entitytype: "artist"))
    end

    it { is_expected.to include(artist) }
  end
end
