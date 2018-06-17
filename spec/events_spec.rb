RSpec.describe Demio::Client::Events do
  before(:each) do
    options = {
      api_secret: "12345",
      api_key: "xyz0987"
    }
    @client = Demio::Client.new(options)
  end

  it "makes a GET request to Demio's event listing endpoint" do
    response = [
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
    ]
    stub_request(:get, "https://my.demio.com/api/v1/events")
      .to_return(body: response.to_json, status: 200)

    response = @client.events
    expect(response.code).to eq("200")
    expect(a_request(:get, "https://my.demio.com/api/v1/events"))
      .to have_been_made.times(1)
  end
end
