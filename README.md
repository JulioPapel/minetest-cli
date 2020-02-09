# Minetest::Cli

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/minetest/cli`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minetest-cli'
```

And then execute:
```sh
    $ bundle install
```
Or install it yourself as:
```sh
    $ gem install minetest-cli
```   
## Instaling Jupyter-Lab Notebooks
### Installation for JRuby
You can use Java classes in your IRuby notebook.

JRuby version >= 9.0.4.0
cztop gem
iruby gem
After installation, make sure that your env is set up to use jruby.
```sh
    $ env ruby -v
```

If you use RVM, it is enough to switch the current version to jruby.
```sh
port install libtool autoconf automake autogen
gem install ffi-rzmq
gem install iruby
```

If you have already used IRuby with a different version, you need to generate a new kernel:
```sh
    $ iruby register --force 
```
```sh
    $ jupyter lab
```
the tutorial file is called tutorial.ipynb

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/minetest-cli. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/minetest-cli/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Minetest::Cli project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/minetest-cli/blob/master/CODE_OF_CONDUCT.md).
