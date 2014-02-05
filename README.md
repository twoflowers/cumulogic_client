# CumulogicClient

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'cumulogic_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cumulogic_client

## Usage

TODO: Write usage instructions here

## Testing

Tests can be run using "rake test".  The test suite requires a working 
CumuLogic controller target, and a username and password with permission 
to deploy services.

In order to provide the test suite with the required credentials, place a 
YAML file at ~/.cumulogic_client.yml with the following contents:

URL: https://demo.cumulogic.com/cumulogic/REST/
USER: yourusername
PASSWORD: yourpassword
SSL: true


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
