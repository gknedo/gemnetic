module Gemnetic
  class World
    attr_accessor :population_size, :population_keep
    attr_reader :specimen_class, :population

    def initialize(specimen_class, params = {})
      raise ArgumentError.new("Specimen Class can't be nil") unless specimen_class
      raise ArgumentError.new("Specimen Class must be a kind of Gemnetic::Specimen") unless specimen_class.ancestors.include?(Gemnetic::Specimen)

      @specimen_class = specimen_class
      @population_size = params.fetch(:population_size, 50)
      @population_keep = params.fetch(:population_keep, 5)
      @population = []
      @population_size.times do
        @population.push specimen_class.new
      end
    end
  end
end
