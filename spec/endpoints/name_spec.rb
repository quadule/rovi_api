require "spec_helper"

describe RoviAPI::Endpoints::Name do
  let(:client) { RoviAPI::Client.new(connection: connection) }
  let(:connection) { double(:faraday) }
  let(:artist) { Hashie::Rash.new(name: "Artist Name") }
  before do
    allow(connection).to receive(:get).and_return(
      double(:response, body: Hashie::Rash.new(name: artist))
    )
  end

  describe "#info" do
    subject { client.data.name.info(name: "Artist Name") }

    before do
      expect(connection).to receive(:get)
        .with("data/v1.1/name/info", hash_including(name: "Artist Name"))
    end

    it { is_expected.to eq(artist) }
  end
end
