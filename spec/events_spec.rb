# frozen_string_literal: true

RSpec.describe Demio::Client::Events do
  let(:options) do
    {
      api_secret: "12345",
      api_key: "xyz0987"
    }
  end
  let(:client) { Demio::Client.new(options) }
  let(:stubbed_response_body) do
    [
      {
        "id" => 62,
        "name" => "First Webinar",
        "date_id" => 1218,
        "status" => "running",
        "timestamp" => 1_456_723_800,
        "zone" => "Europe/Kiev",
        "registration_url" => "http://my.demio.loc/ref/FKXeiDqyQsRYbfiv"
      },
      {
        "id" => 45,
        "name" => "Second Webinar",
        "date_id" => 1196,
        "status" => "scheduled",
        "timestamp" => 1_456_765_200,
        "zone" => "America/New_York",
        "registration_url" => "http://my.demio.loc/ref/pgRzWQhYLPmuboOA"
      }
    ].to_json
  end

  it "makes a GET request to Demio's event listing endpoint" do
    stub_request(:get, "https://my.demio.com/api/v1/events")
      .to_return(body: stubbed_response_body, status: 200)

    response = client.events
    expect(response.code).to eq("200")
    expect(response.body).to eq(stubbed_response_body)
    expect(a_request(:get, "https://my.demio.com/api/v1/events"))
      .to have_been_made.times(1)
  end

  context "with additional param" do
    it "makes a GET request to Demio's event listing endpoint with param" do
      stub_request(:get, "https://my.demio.com/api/v1/events?type=upcoming")
        .to_return(body: stubbed_response_body, status: 200)

      response = client.events("upcoming")
      expect(response.code).to eq("200")
      expect(response.body).to eq(stubbed_response_body)
      expect(a_request(:get, "https://my.demio.com/api/v1/events?type=upcoming"))
        .to have_been_made.times(1)
    end
  end
end
