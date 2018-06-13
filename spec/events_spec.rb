RSpec.describe Demio::Client::Events do
  before(:each) do
    options = {
      api_secret: "12345",
      api_key: "xyz0987"
    }
    @client = Demio::Client.new(options)
  end

  it "makes a GET request to Demio's event listing endpoint"
end
