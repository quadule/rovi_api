require "spec_helper"

describe RoviAPI::Endpoints::Album do
  let(:client) { RoviAPI::Client.new(connection: connection) }
  let(:connection) { double(:faraday) }
  let(:response) { double(:response, body: double(:body, album: album)) }
  let(:album) { Hashie::Rash.new(name: "Album Name") }
  before { allow(connection).to receive(:get).and_return(response) }

  describe "#info" do
    subject { client.data.album.info(name: "Album Name") }

    before do
      expect(connection).to receive(:get)
        .with("data/v1.1/album/info", hash_including(name: "Album Name"))
    end

    it { is_expected.to eq(album) }
  end
end
