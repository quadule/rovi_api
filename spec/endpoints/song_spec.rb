require "spec_helper"

describe RoviAPI::Endpoints::Song do
  let(:client) { RoviAPI::Client.new(connection: connection) }
  let(:connection) { double(:faraday) }
  let(:song) { Hashie::Rash.new(title: "Song Name") }
  before do
    allow(connection).to receive(:get).and_return(
      double(:response, body: Hashie::Rash.new(song: song))
    )
  end

  describe "#info" do
    subject { client.data.song.info(track: "Song Name") }

    before do
      expect(connection).to receive(:get)
        .with("data/v1.1/song/info", hash_including(track: "Song Name"))
    end

    it { is_expected.to eq(song) }
  end
end
