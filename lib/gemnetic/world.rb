module Gemnetic
  class World
    attr_accessor :population_size, :population_keep, :population,
      :mix_probability, :mutate_probability, :tournament_probability
    attr_reader :specimen_class, :current_generation

    def initialize(specimen_class, params = {})
      @specimen_class = specimen_class
      @population_size = params.fetch(:population_size, 50)
      @population_keep = params.fetch(:population_keep, @population_size/10)

      probabilities = [
        params.fetch(:mix_probability, 0.4).to_f,
        params.fetch(:mutate_probability, 0.1).to_f,
        params.fetch(:tournament_probability, 0.5).to_f
      ]
      probabilities_sum = probabilities.sum
      @mix_probability = probabilities[0] * probabilities_sum
      @mutate_probability = probabilities[1] * probabilities_sum
      @tournament_probability = probabilities[2] * probabilities_sum

      @current_generation = 0
      @population = []

      validate

      initialize_population if params.fetch(:initialize_population, true)
    end

    def next_generation
      new_population = population_to_keep
      to_create = @population_size - @population_keep

      (to_create*@tournament_probability).to_i.times do
        new_population.push @population.sample.battle(@population.sample).dup
      end

      (to_create*@mutate_probability).to_i.times do
        new_population.push @population.sample.dup.mutate
      end

      (to_create*@mix_probability).to_i.times do
        new_population.push @population.sample.dup.mix(@population.sample.dup)
      end

      new_population.uniq! { |specimen| specimen.gens }
      while new_population.count < @population_size do
        new_population.push @population.sample.dup.mutate
        new_population.uniq! { |specimen| specimen.gens }
      end

      @current_generation += 1
      @population = new_population
    end

    def population_to_keep
      keep = []
      @population.each do |specimen|
        next keep.push(specimen) if keep.count < @population_keep
        keep.sort_by! { |specimen| specimen.evaluate }
        keep[0] = specimen if specimen.evaluate > keep[0].evaluate
      end

      keep
    end

    private

    def validate
      raise ArgumentError.new("Specimen Class can't be nil") unless @specimen_class
      raise ArgumentError.new("Specimen Class must be a kind of Gemnetic::Specimen") unless @specimen_class.ancestors.include?(Gemnetic::Specimen)
    end

    def initialize_population
      @population_size.times do
        @population.push @specimen_class.new
      end
    end

  end
end
