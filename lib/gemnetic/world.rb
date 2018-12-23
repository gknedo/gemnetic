module Gemnetic
  class World
    attr_accessor :population_size, :population_keep, :population
    attr_reader :specimen_class, :current_generation

    def initialize(specimen_class, params = {})
      raise ArgumentError.new("Specimen Class can't be nil") unless specimen_class
      raise ArgumentError.new("Specimen Class must be a kind of Gemnetic::Specimen") unless specimen_class.ancestors.include?(Gemnetic::Specimen)

      @specimen_class = specimen_class
      @population_size = params.fetch(:population_size, 50)
      @population_keep = params.fetch(:population_keep, 5)
      @current_generation = 0
      @population = []

      if params.fetch(:initialize_population, true)
        @population_size.times do
          specimen = @specimen_class.new
          specimen.generation = @current_generation
          @population.push specimen
        end
      end
    end

    def next_generation
      new_population = []
    end

    def population_to_keep
      @population.sort_by { |specimen| specimen.evaluate }.last(@population_keep)
    end

  end
end
