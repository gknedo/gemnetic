module Gemnetic
  class World
    attr_accessor :population_size, :population_keep
    attr_reader :specimen_class

    def initialize(specimen_class, params = {})
      raise ArgumentError.new("Specimen Class can't be nil") unless specimen_class
      raise ArgumentError.new("Specimen Class must be a kind of Gemnetic::Specimen") unless specimen_class.ancestors.include?(Gemnetic::Specimen)
      @specimen_class = specimen_class
      @population_size = params.fetch(:population_size, 50)
      @population_keep = params.fetch(:population_keep, 5)
    end
  end
end
