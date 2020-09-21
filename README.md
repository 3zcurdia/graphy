# Graphy

Create any diagram as code

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'graphy'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install graphy

## Usage

### Module

```ruby
Graphy.define 'Life View' do
  entity 'Friendly'
  namespace "Animal Kingdom" do
    entity 'Animal' do
      attributes :name
    end

    entity 'Dog', 'Animal' do
      attributes :color
      uses 'Friendly'
    end

    entity 'Cat', 'Animal' do
      attributes :scratch
    end
  end

  write(png: 'hello.png')
end
```

![example02.png](https://github.com/3zcurdia/graphy/blob/master/examples/example02.rb.png)


### State machine

```ruby
Graphy.define 'State machine' do
  node 'A'
  node 'B', shape: 'diamond'
  node 'C'
  node 'D', shape: 'egg'

  step 'A', to: 'B'
  step 'B', to: 'C'
  step 'C', to: 'A'
  step 'C', to: 'D'
  step 'D', to: 'C'

  write(png: 'steps.png')
end
```
![example01.png](https://github.com/3zcurdia/graphy/blob/master/examples/example01.rb.png)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/3zcurdia/graphy. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/3zcurdia/graphy/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Arq project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/3zcurdia/graphy/blob/master/CODE_OF_CONDUCT.md).
