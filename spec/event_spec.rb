# frozen_string_literal: true

RSpec.describe Demio::Client::Event do
  let(:options) do
    {
      api_secret: "12345",
      api_key: "xyz0987"
    }
  end
  let(:client) { Demio::Client.new(options) }

  it "makes a GET request to Demio's event fetch endpoint" do
    event_id = 4567
    stubbed_response_body = {
      "id" => event_id,
      "date_id" => 35,
      "name" => "John Doe",
      "email" => "john.doe@gmail.com"
    }.to_json

    stub_request(:get, "https://my.demio.com/api/v1/event/#{event_id}")
      .to_return(body: stubbed_response_body, status: 200)

    response = client.event(event_id)
    expect(response.code).to eq("200")
    expect(response.body).to eq(stubbed_response_body)
    expect(a_request(:get, "https://my.demio.com/api/v1/event/#{event_id}"))
      .to have_been_made.times(1)
  end
end
