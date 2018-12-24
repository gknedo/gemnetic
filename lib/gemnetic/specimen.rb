module Gemnetic
  class Specimen
    attr_accessor :gens

    def initialize(params = {})
      @gens = params.fetch(:gens, randomize)
    end

    def mix specimen
      raise NotImplementedError, "You must override the mix method to mix two specimens in a new one"
    end

    def mutate
      raise NotImplementedError, "You must override the mutate method to generate a new specimen based current specimen"
    end

    def evaluate
      raise NotImplementedError, "You must override the evaluate method to calculate the fitness of the specimen"
    end

    def randomize
      raise NotImplementedError, "You must override the randomize method to randomize the gens of the specimen"
    end

    def battle specimen
      return self unless self.evaluate < specimen.evaluate
      specimen
    end

    def dup
      self.class.new(@gens.dup)
    end

    def to_s
      {
        evaluation: evaluate,
        gens: @gens
      }.to_s
    end
  end
end
