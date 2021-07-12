# frozen_string_literal: true

RSpec.describe Demio::Client do
  let(:options) do
    {
      api_secret: "12345",
      api_key: "xyz0987"
    }
  end
  let(:stubbed_response_body) { [{ id: 1, value: "test" }].to_json }
  let(:client) { described_class.new(options) }

  context "request headers" do
    it "correctly sets headers" do
      stub_request(
        :get,
        "https://my.demio.com/api/v1/ping/query?api_key=xyz0987&api_secret=12345"
      )

      client.ping
      expect(
        a_request(
          :get,
          "https://my.demio.com/api/v1/ping/query?api_key=xyz0987&api_secret=12345"
        ).with(
          headers: {
            "Api-Key" => "xyz0987",
            "Api-Secret" => "12345",
            "Content-Type" => "application/json",
            "User-Agent" => "Demio Ruby Client - #{Demio::VERSION}"
          }
        )
      ).to have_been_made.times(1)
    end
  end

  context "#ping" do
    it "makes a GET ping request" do
      ping_response = { "pong" => true }

      stub_request(:get, "https://my.demio.com/api/v1/ping/query?api_key=xyz0987&api_secret=12345")
        .to_return(body: ping_response.to_json, status: 200)

      response = client.ping
      expect(response.code).to eq("200")
      expect(
        a_request(
          :get, "https://my.demio.com/api/v1/ping/query?api_key=xyz0987&api_secret=12345"
        )
      ).to have_been_made.times(1)
    end
  end

  context "#get" do
    it "makes a GET request" do
      target_path = "endpoint?query=1"
      stub_request(:get, "https://my.demio.com/api/v1/#{target_path}")
        .to_return(body: stubbed_response_body, status: 200)

      response = client.get(target_path)
      expect(response.code).to eq("200")
      expect(response.body).to eq(stubbed_response_body)
      expect(
        a_request(
          :get, "https://my.demio.com/api/v1/#{target_path}"
        )
      ).to have_been_made.times(1)
    end
  end

  context "#put" do
    it "makes a PUT request" do
      target_path = "endpoint"
      payload = { event_id: 1234 }

      stub_request(:put, "https://my.demio.com/api/v1/#{target_path}")
        .with(body: payload.to_json)
        .to_return(body: stubbed_response_body, status: 200)

      response = client.put(target_path, payload)
      expect(response.code).to eq("200")
      expect(response.body).to eq(stubbed_response_body)
      expect(a_request(:put, "https://my.demio.com/api/v1/#{target_path}")
        .with(body: payload.to_json))
        .to have_been_made.times(1)
    end
  end

  context "response is a redirect" do
    it "follows the redirect" do
      target_path = "endpoint?query=1"
      follow_url = "https://my.demio.com/api/v1/redirect"
      stub_request(:get, "https://my.demio.com/api/v1/#{target_path}")
        .to_return(headers: { "Location" => follow_url }, body: stubbed_response_body, status: 301)
      stub_request(:get, follow_url)
        .to_return(body: stubbed_response_body, status: 200)

      response = client.get(target_path)
      expect(response.code).to eq("200")
    end

    it "raises an error if number of redirects exceed the limit" do
      target_path = "endpoint?query=1"
      stub_const("Demio::Client::REQUEST_REDIRECT_FOLLOW_LIMIT", 1)
      stub_request(:get, "https://my.demio.com/api/v1/#{target_path}")
        .to_return(body: stubbed_response_body, status: 301)

      expect { client.get(target_path) }
        .to raise_error(Demio::TooManyRedirectsError, "too many HTTP redirects")
    end
  end
end
