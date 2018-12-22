RSpec.describe Gemnetic::World do
  describe 'initializing the world' do
    subject { Gemnetic::World.new(params) }
    let(:params) { {} }

    it 'must be a Gemnetic::World' do
      expect(subject).to be_a(Gemnetic::World)
    end

    it 'must set the population size' do
      expect(subject.population_size).to be > 0
    end

    it 'must set the population keep' do
      expect(subject.population_keep).to be > 0
    end
  end

  describe 'setting the specimen class' do
    xit 'must be a specimen subclass'
    xit 'cant be nil'
  end
end
