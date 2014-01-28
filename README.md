# The viagogo Ruby Gem

[![Gem Version](https://badge.fury.io/rb/viagogo-client.png)][gem]
[![Build Status](https://secure.travis-ci.org/akilb/viagogo.rb.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/akilb/viagogo.rb.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/akilb/viagogo.rb.png)][codeclimate]

[gem]: http://rubygems.org/gems/viagogo-client
[travis]: http://travis-ci.org/akilb/viagogo.rb
[gemnasium]: https://gemnasium.com/akilb/viagogo.rb
[codeclimate]: https://codeclimate.com/github/akilb/viagogo.rb

Ruby toolkit for working with the viagogo API

## Installation

Add this line to your application's Gemfile:

    gem 'viagogo-client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install viagogo-client

## Usage
```ruby
require 'viagogo-client'

# All methods require authentication. To get your viagogo OAuth credentials,
# see http://developer.viagogo.net/firststeps
client = Viagogo::Public::Client do |config|
  config.consumer_key = YOUR_CONSUMER_KEY
  config.consumer_secret = YOUR_CONSUMER_SECRET
end

token = client.get_access_token
client.access_token = token.oauth_token
client.access_token_secret = token.oauth_token_secret

# Get a list of events that match the given search query
events = client.events_search "FC Barcelona tickets"

# Pass query parameters as a hash of options
events = clients.events_search "FC Barcelona tickets", :page => 2
```

## Contributing

1. Fork it ( http://github.com/akilb/viagogo.rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
