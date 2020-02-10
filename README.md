# Minetest::Cli

(https://github.com/JulioPapel/minetest-cli)

Tutorial: (tutorial.md)

Welcome to minetest-cli gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. 

Put your Ruby code in the commands section of this tutorial:   

To experiment with that code, run `$ bundle exec bin/minetest-cli` 
or 
`$ rake console` for an interactive prompt.

## Installation

Add this line to any Ruby application's Gemfile:

```ruby
gem 'minetest-cli'
```

And then execute:
```sh
$ bundle install
```
Or install it yourself inside deas:
```sh
$ gem install https://github.com/JulioPapel/minetest-cli/blob/master/minetest-cli-0.2.0.gem
```   

## To Install Jupyter-Lab Notebooks
We use Jupyter notebooks for the tutorial, (currently only in Portuguese) in the file named `tutorial.ipynb`
If you do not want to install Jupyter the tutorial is also available in PDF in the file names `tutorial.pdf`

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
$ port install libtool autoconf automake autogen
$ brew install pandoc
$ brew cask install basictex
$ gem install ffi-rzmq
$ gem install iruby
```

If you have already used IRuby with a different version, you need to generate a new kernel:
```sh
$ iruby register --force 
```
```sh
$ jupyter lab
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Minetest::Cli project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/minetest-cli/blob/master/CODE_OF_CONDUCT.md).
