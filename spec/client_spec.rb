# frozen_string_literal: true

RSpec.describe Demio::Client do
  before(:each) do
    options = {
      api_secret: "12345",
      api_key: "xyz0987"
    }
    @client = Demio::Client.new(options)
  end

  context "request headers" do
    it "correctly sets headers" do
      stub_request(
        :get,
        "https://my.demio.com/api/v1/ping/query?api_key=xyz0987&api_secret=12345"
      )

      @client.ping
      expect(
        a_request(
          :get,
          "https://my.demio.com/api/v1/ping/query?api_key=xyz0987&api_secret=12345"
        )
        .with(headers: {
                "Api-Key" => "xyz0987",
                "Api-Secret" => "12345",
                "Content-Type" => "application/json",
                "User-Agent" => "Demio Ruby Client - #{Demio::VERSION}"
              })
      ).to have_been_made.times(1)
    end
  end

  context "#ping" do
    it "makes a GET ping request" do
      ping_response = {
        "pong" => true
      }

      stub_request(:get, "https://my.demio.com/api/v1/ping/query?api_key=xyz0987&api_secret=12345")
        .to_return(body: ping_response.to_json, status: 200)

      response = @client.ping
      expect(response.code).to eq("200")
      expect(
        a_request(
          :get,
          "https://my.demio.com/api/v1/ping/query?api_key=xyz0987&api_secret=12345"
        )
      ).to have_been_made.times(1)
    end
  end
end
