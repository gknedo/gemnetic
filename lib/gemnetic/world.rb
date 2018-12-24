require 'pickup'

module Gemnetic
  class World
    attr_accessor :population_size, :population_keep, :population
    attr_reader :specimen_class, :current_generation

    def initialize(specimen_class, params = {})
      @specimen_class = specimen_class
      @population_size = params.fetch(:population_size, 50)
      @population_keep = params.fetch(:population_keep, @population_size/10)
      @pickup = Pickup.new({
        mix: params.fetch(:mix_probability, 4),
        mutate: params.fetch(:mutate_probability, 1),
        tournament: params.fetch(:tournament_probability, 5)
      })

      @current_generation = 0
      @population = []

      validate

      initialize_population if params.fetch(:initialize_population, true)
    end

    def next_generation
      new_population = []
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
        specimen = @specimen_class.new
        specimen.generation = @current_generation
        @population.push specimen
      end
    end

  end
end
