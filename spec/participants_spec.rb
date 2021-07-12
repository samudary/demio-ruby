# frozen_string_literal: true

RSpec.describe Demio::Client::Participants do
  let(:options) do
    {
      api_secret: "12345",
      api_key: "xyz0987"
    }
  end
  let(:client) { Demio::Client.new(options) }
  let(:stubbed_response_body) do
    {
      "participants" => [
        {
          "email" => "simulation+dave@demio.com",
          "name" => "Dave",
          "custom_fields" => [],
          "attended" => false,
          "status" => "did not attend"
        },
        {
          "email" => "simulation+ansley@demio.com",
          "name" => "Ansley",
          "custom_fields" => [],
          "attended" => false,
          "status" => "did not attend"
        }
      ]
    }.to_json
  end
  let(:event_date_id) { 1234 }

  it "makes a GET request to Demio's participants endpoint" do
    stub_request(:get, "https://my.demio.com/api/v1/report/#{event_date_id}/participants")
      .to_return(body: stubbed_response_body, status: 200)

    response = client.participants(event_date_id)
    expect(response.code).to eq("200")
    expect(response.body).to eq(stubbed_response_body)
    expect(a_request(:get, "https://my.demio.com/api/v1/report/#{event_date_id}/participants"))
      .to have_been_made.times(1)
  end

  context "with additional param" do
    it "makes a GET request to Demio's participants endpoint with param" do
      stub_request(:get, "https://my.demio.com/api/v1/report/#{event_date_id}/participants?status=left-early")
        .to_return(body: stubbed_response_body, status: 200)

      response = client.participants(event_date_id, "left-early")
      expect(response.code).to eq("200")
      expect(response.body).to eq(stubbed_response_body)
      expect(a_request(:get, "https://my.demio.com/api/v1/report/#{event_date_id}/participants?status=left-early"))
        .to have_been_made.times(1)
    end
  end
end
