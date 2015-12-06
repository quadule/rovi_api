require "spec_helper"

describe RoviAPI::Client do
  subject(:client) { described_class.new(connection: connection) }
  let(:connection) { double(:faraday) }
  let(:response)   { double(:response, body: double(:body)) }

  describe "#get" do
    subject { client.get(:search, "v2.1", :music, :search) }

    before do
      expect(connection).to receive(:get)
        .with("search/v2.1/music/search",
          hash_including(apikey: "key", sig: /\A[0-9a-f]{32}\z/)
        ).and_return(response)
    end

    it { is_expected.to eq(response.body) }
  end
end
