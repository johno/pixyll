# PocketApi
Rubygem for Pocket (getpocket.com) API, formerly ReadItLater.

## Installation

Add this line to your application's Gemfile:

    gem 'pocket_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pocket_api

## Usage

1. Get an API Key from http://getpocket.com/developer/ and attain and access_token
2. Setup PocketApi credentials with:
```
PocketApi.configure(:client_key=> API_KEY, :access_token => ACCESS_TOKEN)
```
3. Call API with corresponding API methods (retrieve, add, modify)
```
PocketApi.retrieve({:state => "unread"})
PocketApi.add("http://example.com", {:title => "Test add"})
PocketApi.modify("archive", {:item_id => "123456"})
```

There's also some OAuth helper methods in PocketApi::Connection to generate Request Tokens, Authorize URLs, and Access Tokens.
Here's a possible workflow:
1. Generate Authorize URL for user to log in:
```
PocketApi::Connection.client_key = API_KEY
PocketApi::Connection.generate_authorize_url("https://myserver/authorize_callback", "https://myserver/denied_authorize")
```
2. Once user returns, generate access token from previous request_token 
```
PocketApi::Connection.client_key = API_KEY
PocketApi::Connection.generate_access_token
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## TODO
Create an Exception object for Pocket requests that parses header for "X-Error" and rate limiting stuff.
