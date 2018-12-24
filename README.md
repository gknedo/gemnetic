# Gemnetic

A simple genetic algorithm implementation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gemnetic'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gemnetic

## Usage
Create a specimen class implementing the evaluate, randomize, crossover and mutate methods.
```
class MySpecimen < Gemnetic::Specimen

  def evaluate
    # returns a specimen evaluation, big is better.
  end

  def mutate
    # mutate the @gens variable and returns self
  end

  def randomize
    # returns random gens
  end

  def crossover specimen
    # crossover @gens with the specimen.gens and return self
  end
end
```

Initialize a world with:
```
world = Gemnetic::World.new(MySpecimenClass)
```

Run some steps and get the best
```
50.times do
    world.next_generation
end
world.best_specimen
```

DONE!


See a full example [here](https://github.com/gknedo/gemnetic/blob/master/example/run.rb).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gknedo/gemnetic. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Gemnetic project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/gknedo/gemnetic/blob/master/CODE_OF_CONDUCT.md).
