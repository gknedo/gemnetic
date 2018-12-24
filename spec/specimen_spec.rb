RSpec.describe Gemnetic::Specimen do
  let!(:specimen) { MockedSpecimen.new }

  describe 'the crossover method' do
    subject { specimen.crossover(MockedSpecimen.new) }

    it 'must be implemented on inheritance' do
      expect {subject}.to raise_error NotImplementedError
    end
  end

  describe 'the mutate method' do
    subject { specimen.mutate }

    it 'must be implemented on inheritance' do
      expect {subject}.to raise_error NotImplementedError
    end
  end

  describe 'the evaluate method' do
    subject { specimen.evaluate }

    it 'must be implemented on inheritance' do
      expect {subject}.to raise_error NotImplementedError
    end
  end

  describe 'battle' do
    let!(:specimen_2) { MockedSpecimen.new }
    before do
      allow(specimen_2).to receive(:evaluate).and_return(rand(1..10))
      allow(specimen).to receive(:evaluate).and_return(rand(11..20))
    end

    subject { specimen.battle(specimen_2) }

    it 'must return the specimen with highest evaluation' do
      expect(subject).to eq specimen
    end
  end
end
