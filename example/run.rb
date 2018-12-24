require 'gemnetic'
require_relative 'my_specimen'

world = Gemnetic::World.new(MySpecimen)
150.times do
  p "GEN: #{world.current_generation} "
  p world.population_to_keep.map{|specimen| specimen.evaluate}
  world.next_generation
end

p world.population_to_keep.map{ |specimen| specimen.gens }
p world.best_specimen
p world.best_specimen.evaluate
