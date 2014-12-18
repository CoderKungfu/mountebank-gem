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

## Contributing

1. Fork it ( https://github.com/CoderKungfu/mountebank/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
