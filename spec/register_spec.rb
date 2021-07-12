# frozen_string_literal: true

RSpec.describe Demio::Client::Register do
  before(:each) do
    options = {
      api_secret: "12345",
      api_key: "xyz0987"
    }
    @client = Demio::Client.new(options)
  end

  it "makes a PUT request to Demio's event registration endpoint" do
    payload = {
      "id" => 1,
      "date_id" => 35,
      "name" => "Jane Doe",
      "email" => "jane.doe@gmail.com"
    }
    registration_response = {
      "join_link" => "https://event.demio.com/join/fPaSYijVHXI6ZJgE"
    }

    stub_request(:put, "https://my.demio.com/api/v1/event/register")
      .with(body: payload.to_json)
      .to_return(body: registration_response.to_json, status: 200)

    response = @client.register(payload)
    expect(response.code).to eq("200")
    expect(a_request(:put, "https://my.demio.com/api/v1/event/register")
      .with(body: payload.to_json))
      .to have_been_made.times(1)
  end
end
