# rubocop-fjord

rubocop-fjord is a rubocop configuration from Fjord, Inc.

## Installation

Add this line to your application's Gemfile:

```ruby
# For plain Ruby scripts
group :development do
  gem 'rubocop-fjord', require: false
end
```

```ruby
# For Rails projects
group :development do
  gem 'rubocop-fjord', require: false
  gem 'rubocop-rails', require: false
end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubocop-fjord

## Usage

Add `inherit_gem:` setting to your `.rubocop.yml`:

```yml
# For plain Ruby scripts
inherit_gem:
  rubocop-fjord:
    - "config/rubocop.yml"
```

```yml
# For Rails projects
inherit_gem:
  rubocop-fjord:
    - "config/rubocop.yml"
    - "config/rails.yml"
```

Run `rubocop` command:

```
$ rubocop
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/komagata/rubocop-fjord. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rubocop::Fjord project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/komagata/rubocop-fjord/blob/master/CODE_OF_CONDUCT.md).
