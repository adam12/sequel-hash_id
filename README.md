# Sequel Hash ID

Easily obfuscate your Integer-based primary keys in Sequel models. The anonymity
of a UUID without any overhead.

These are commonly used for URL shorteners, but they have other use cases as well.
Specifically, they are very handy to prevent nieve crawling / scraping, where your
records are known to be incremental.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "sequel-hash_id"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sequel-hash_id

## Usage

This plugin likely only makes sense at the Model level, so configure it
for each model you want to have a hashid for. The only required option
is the salt you wish to use.

    plugin :hash_id, salt: "your-salt".freeze

Once you've done that, you can now access the following methods:

    # Get the instance's hashid
    instance = YourModel.create
    instance.hashid

    # Lookup using a hashid
    YourModel.with_hashid("the-hashid")

    # Dataset lookup method
    YourModel.where { someproperty == true }.with_hashid("the-hashid")

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/adam12/sequel-hash_id.

I love pull requests! If you fork this project and modify it, please ping me to see
if your changes can be incorporated back into this project.

That said, if your feature idea is nontrivial, you should probably open an issue to
[discuss it](http://www.igvita.com/2011/12/19/dont-push-your-pull-requests/)
before attempting a pull request.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

