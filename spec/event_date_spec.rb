# frozen_string_literal: true

RSpec.describe Demio::Client::EventDate do
  let(:options) do
    {
      api_secret: "12345",
      api_key: "xyz0987"
    }
  end
  let(:client) { Demio::Client.new(options) }

  it "makes a GET request to Demio's event date endpoint" do
    event_id = 4567
    date_id = 35
    stubbed_event_response_body = {
      "date_id" => 35,
      "status" => "scheduled",
      "timestamp" => 1_456_723_800,
      "datetime" => "March 26th, 2016 at 8:00PM EET",
      "zone" => "Europe/Kiev"
    }.to_json

    stub_request(:get, "https://my.demio.com/api/v1/event/#{event_id}/#{date_id}")
      .to_return(body: stubbed_event_response_body, status: 200)

    response = client.event_date(event_id, date_id)
    expect(response.code).to eq("200")
    expect(response.body).to eq(stubbed_event_response_body)
    expect(a_request(:get, "https://my.demio.com/api/v1/event/#{event_id}/#{date_id}"))
      .to have_been_made.times(1)
  end
end
