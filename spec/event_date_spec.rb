# frozen_string_literal: true

RSpec.describe Demio::Client::EventDate do
  before(:each) do
    options = {
      api_secret: "12345",
      api_key: "xyz0987"
    }
    @client = Demio::Client.new(options)
  end

  it "makes a GET request to Demio's event date endpoint" do
    event_id = 4567
    date_id = 35
    event_response = {
      "date_id" => 35,
      "status" => "scheduled",
      "timestamp" => 1_456_723_800,
      "datetime" => "March 26th, 2016 at 8:00PM EET",
      "zone" => "Europe/Kiev"
    }

    stub_request(:get, "https://my.demio.com/api/v1/event/#{event_id}/#{date_id}")
      .to_return(body: event_response.to_json, status: 200)

    response = @client.event_date(event_id, date_id)
    expect(response.code).to eq("200")
    expect(a_request(:get, "https://my.demio.com/api/v1/event/#{event_id}/#{date_id}"))
      .to have_been_made.times(1)
  end
end
