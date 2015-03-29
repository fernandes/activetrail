# ActiveTrail
[![Build Status](https://travis-ci.org/fernandes/activetrail.svg?branch=master)](https://travis-ci.org/fernandes/activetrail)
[![Code Climate](https://codeclimate.com/github/fernandes/activetrail/badges/gpa.svg)](https://codeclimate.com/github/fernandes/activetrail)
[![Test Coverage](https://codeclimate.com/github/fernandes/activetrail/badges/coverage.svg)](https://codeclimate.com/github/fernandes/activetrail)

Provides integration between ActiveAdmin and Trailblazer, cool hun?!

## Disclaimer

This is a BETA piece of software, please, don't use in production (yet)!

It won't work until some PRs got merged on upstream repos:

- [ ] Formtastic (Discover fields on a form object not just ActiveRecord) https://github.com/justinfrench/formtastic/pull/1142
- [ ] Reform (Expose contract fields) https://github.com/apotonick/reform/pull/212
- [ ] Trailblazer (Feature: Add operation collection) https://github.com/apotonick/trailblazer/pull/36
- [ ] Trailblazer (Feature: Add pagination and scope to collection) https://github.com/apotonick/trailblazer/pull/39
- [ ] Bonus! Trailblazer (Feature: Add authorization) https://github.com/apotonick/trailblazer/pull/41

In meanwhile you can use my forks:

```ruby
gem "trailblazer", github: "fernandes/trailblazer", branch: "master"
gem "reform", github: "fernandes/reform", branch: "feature/expose_contract_fields"
gem "formtastic", github: "fernandes/formtastic", branch: "feature/get_fields_from_form_object"
```

I'm keeping my branches even with upstream's util everything is ok.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activetrail'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activetrail

## Usage

In your `app/admin/book.rb` you need to customize your controller to make ActiveAdmin use Trailblazer, and ActiveTrail provides an easy way to make this integration happen! Just edit your resource like this:

```ruby
ActiveAdmin.register Book do
  # everything happens here :D
  controller do
    include ActiveTrail::Controller
  end
end
```

You need to implement Book::(__Create|Update|Index|Show__) in your operation so everything works fine. If you need an example, check ActiveTrail's [Book Operation](https://github.com/fernandes/activetrail/blob/7a5adf4241ff2299dcf4be2336765723a27a488a/spec/internal/app/models/book.rb) used on its test suite

## Known Issues

1. Just works with single Models. (Maybe works, maybe not with releationship, but we still do not support).
2. Do not support batch operations.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

1. Fork it ( https://github.com/fernandes/activetrail/fork )
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create a new Pull Request

Always test against ActiveAdmin and Trailblazer latest release and master branch.
