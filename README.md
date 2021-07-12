# Demio Ruby Client

![example workflow](https://github.com/samudary/demio-ruby/actions/workflows/ruby.yml/badge.svg)


A Ruby gem for interacting with the [Demio API](https://publicdemioapi.docs.apiary.io/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem "demio-ruby", require: "demio"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install demio-ruby

## Usage

Retrieve your API key and API secret from [here](https://my.demio.com/manage/api-details) and initialize the client:

```ruby
client = Demio::Client.new(
  api_secret: "YOUR API SECRET",
  api_key: "YOUR API KEY"
)
```

### Methods

| Actions                    | Methods                                              |
| :------------------------- | :--------------------------------------------------- |
| List events                | `#events`                                            |
| Fetch an event             | `#event(event_id)`                                   |
| Fetch event date info      | `#event_date(event_id, event_date_id)`               |
| Fetch participants list    | `#participants(event_date_id)`                       |
| Register a registrant      | `#register(payload = {})`                            |
| Ping                       | `#ping`                                              |


**Examples**

```ruby
client = Demio::Client.new(
  api_secret: "YOUR API SECRET",
  api_key: "YOUR API KEY"
)

payload = {
  "id": 56458,
  "name": "Jane Doe",
  "email": "jane.doe@gmail.com"
}

response = client.register(payload)
response.code
# => "200"

JSON.parse(response.body)
# => {"hash"=>"ADv07WFv0RNDQZoF", "join_link"=>"https://event.demio.com/simulated-webinar/ADv07WFv0RNDQZoF"}

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests and rubocop. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at [here](https://github.com/samudary/demio-ruby/issues). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

1. Fork it ( https://github.com/samudary/demio-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the project’s codebases and ther environments is expected to follow the [code of conduct](https://github.com/samudary/demio-ruby/blob/master/CODE_OF_CONDUCT.md).
