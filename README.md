# Mountebank

A simple Ruby library that lets you manage your [Mountebank test server](http://www.mbtest.org/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mountebank'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mountebank

## Usage

### Pre-Requisite

Install Mountebank:

```
npm install -g mountebank --production
```

Start Mountebank:

```
mb --allowInjection
```

I recommend reading the [Mountebank documentation](http://www.mbtest.org/docs/api/overview) for a deeper understanding of their API.

### Initialization

1. Add these to you environment hash (eg. add to your `.env` file)
	
	```
MOUNTEBANK_SERVER=127.0.0.1
MOUNTEBANK_PORT=2525
```

2. Include the lib in your `spec_helper`.

	```ruby
include 'mountebank'
```

### Get all available imposters

```ruby
Mountebank.imposters
```

### Get all stubs

```ruby
imposter = Mountbank.imposters.first
puts imposter.stubs
```
### Create Imposter

```ruby
port = 4545
protocol = Mountebank::Imposter::PROTOCOL_HTTP
imposter = Mountebank::Imposter.create(port, protocol)
```

### Create Imposter with Stub

```ruby
port = 4545
protocol = Mountebank::Imposter::PROTOCOL_HTTP
imposter = Mountebank::Imposter.build(port, protocol)

# Create a response
status_code = 200
headers = {"Content-Type" => "application/json"}
body = {foo:"bar"}.to_json
response = Mountebank::Stub::HttpResponse(status_code, headers, body)

imposter.add_stub(response)
imposter.save!
```

Check the URL:
```
curl http://127.0.0.1:4545
```

### Create Imposter with Stub & Predicate

```ruby
port = 4545
protocol = Mountebank::Imposter::PROTOCOL_HTTP
imposter = Mountebank::Imposter.build(port, protocol)

# Create a response
status_code = 200
headers = {"Content-Type" => "application/json"}
body = {foo:"bar2"}.to_json
response = Mountebank::Stub::HttpResponse(status_code, headers, body)

# Create a predicate
data = {equals: {path:"/test"}}
predicate = Mountebank::Stub::Predicate(data)

imposter.add_stub(response, predicate)
imposter.save!
```

Check the URL:
```
curl http://127.0.0.1:4545/test
```

## Contributing

1. Fork it ( https://github.com/CoderKungfu/mountebank/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
