# Tolken
Tolken is a Ruby on Rails Gem that allows you to translate database fields using Postgres' jsob data type.

Tolken's API is more verbose than most similar gems. The philosophy is that you should be aware of when you're dealing with translatable fields and what language you're interested in in any given moment. This comes from experience working with gems such as [Globalize](https://github.com/globalize/globalize), while it might fit some projects we've found that the magic that starts out as a convenience quickly becomes a liability.

In Tolken a translatable field is just a Ruby hash which makes it easy to reason about. See *Usage* for details.

[![Build Status](https://travis-ci.org/varvet/tolken.svg?branch=master)](https://travis-ci.org/varvet/tolken)
[![Maintainability](https://api.codeclimate.com/v1/badges/72c772179a8baa586f7f/maintainability)](https://codeclimate.com/github/varvet/tolken/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/72c772179a8baa586f7f/test_coverage)](https://codeclimate.com/github/varvet/tolken/test_coverage)

## Installation
Add this line to your application's Gemfile:

```ruby
gem "tolken"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tolken

## Usage
Make sure you're running Postgres and that the column you want to translate is of the `jsonb` type:

### Setup
```rb
class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.jsonb :title, :jsonb, null: false
      t.timestamps
    end

    execute "CREATE INDEX posts_title_index ON posts USING gin (title)"
  end
end
```

Next you need to configure `I18n` if you haven't already (usually in *config/initializers/locale.rb*):

```rb
I18n.available_locales = %i[en sv de]
```

Tolken expects you to only use translations for the locales in `I18n.available_locales`.

### Persistence
Extend your model with `Tolken` and tell it what column(s) you want to translate:

```rb
class Post < ApplicationRecord
  extend Tolken
  translates :title
end
```

You can now work with `title` as follows:

```rb
post = Post.create(title: { en: "News", sv: "Nyheter" })

post.title # => { en: "News", sv: "Nyheter" }
post.title(:en) # => "News"
post.title(:sv) # => "Nyheter"
post.title(:dk) # ArgumentError, "Invalid locale dk"
post.title(:de) # => nil

post.title = { en: "News", sv: "Nyheter" }
post.title[:en] = "News"
```

### Validation
Tolken comes with support for the *presence* validator:

```rb
class Post < ApplicationRecord
  extend Tolken
  translates :title, presence: true
end

post = Post.create(title: { en: "News", sv: "" })
post.errors.messages # => { name_sv: ["can't be blank"] }
```

Tolken checks that all `I18n.available_locales` has present values.

### View Forms
Tolken has opt-in support for integrating with [SimpleForm](https://github.com/plataformatec/simple_form). To opt-in update your Gemfile:

```ruby
gem "tolken", require: "tolken/simle_form"
```

Now if you add a simple_form field for a translatable field SimpleForm will generate an input per language version:

```erb
<%= simple_form_for(@post) do |form| %>
  <%= form.input :title %>
  <%= form.submit %>
<% end %>
```

By default a text input field is generated. If you want another type you can override with:

```erb
<%= form.input :title, type: :text %>
```

This will instead render one text area per language version.

The specs for [translates](spec/tolken/translates_spec.rb) is a good resource of additional usage examples.

## Development

### Native dependencies
You need to have Postgres installed on your system. This can be done on Mac OS with `brew install postgres`.

### Ruby setup
After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/varvet/tolken. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct. To create a pull request follow these steps:

    $ git clone git@github.com:varvet/tolken.git
    $ cd tolken
    $ git checkout my-feature-branch
    Make changes and commits, consider squashing commits that doesn't add anything by themselves
    $ rubocop
    $ rspec
    Commit, if possible squash in original locations, changes required by rubocop and or failing tests
    $ git checkout master
    $ git pull --rebase
    $ git checkout my-feature-branch
    $ git rebase master
    $ git push

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
