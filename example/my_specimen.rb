require 'gemnetic'
require_relative 'geo'

class MySpecimen < Gemnetic::Specimen

  def evaluate
    (0..9).map do |index|
      next_index = (index+1) % 10
      distance = Geo.get_distance(@gens[index], @gens[next_index])
    end.sum * -1
  end

  def mutate
    swap(rand(0..9), rand(0..9))
    self
  end

  def randomize
    (0..9).to_a.sample(10)
  end

  def crossover specimen
    new_gens = []
    self_enumerator = 0
    specimen_enumerator = 0
    crossover_probability = rand
    while new_gens.count < 10
      from_specimen = rand < crossover_probability
      gen = from_specimen ? specimen.gens[specimen_enumerator] : @gens[self_enumerator]
      next unless gen
      new_gens.push(gen) unless new_gens.include?(gen)
      self_enumerator = (self_enumerator + 1) % 10 unless from_specimen
      specimen_enumerator = (specimen_enumerator + 1) % 10 if from_specimen
    end
    @gens = new_gens
    self
  end

  private

  def swap index_a, index_b
    @gens[index_a], @gens[index_b] = @gens[index_b], @gens[index_a]
  end
end
