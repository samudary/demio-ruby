RSpec.describe Demio::Client::Event do
  before(:each) do
    options = {
      api_secret: "12345",
      api_key: "xyz0987"
    }
    @client = Demio::Client.new(options)
  end

  it "makes a GET request to Demio" do
    event_id = 4567
    event = {
      "id": 1,
      "date_id": 35,
      "name": "John Doe",
      "email": "john.doe@gmail.com"
    }

    stub_request(:get, "https://my.demio.com/api/v1/event/#{event_id}").
      to_return(body: event.to_json, status: 200)

    response = @client.event(event_id)
    expect(response.code).to eq("200")
    expect(a_request(:get, "https://my.demio.com/api/v1/event/#{event_id}")).
      to have_been_made.times(1)
  end
end
