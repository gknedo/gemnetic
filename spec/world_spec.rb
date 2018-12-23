RSpec.describe Gemnetic::World do
  describe 'initializing the world' do
    subject { Gemnetic::World.new(specimen_class) }
    let!(:specimen_class) { MockedSpecimen }

    it 'must be a Gemnetic::World' do
      expect(subject).to be_a(Gemnetic::World)
    end

    it 'must set the population size' do
      expect(subject.population_size).to be > 0
    end

    it 'must set the population keep' do
      expect(subject.population_keep).to be > 0
    end

    describe 'the generated population' do
      it 'must be equal to the population size' do
        expect(subject.population.count).to eq subject.population_size
      end

      it 'must initialize all specimen with random data' do
        subject.population.each do |specimen|
          expect(specimen).to be_a_kind_of(Gemnetic::Specimen)
        end
      end
    end

    describe 'setting the specimen class' do
      context 'as a specimen class' do
        let!(:specimen_class) { MockedSpecimen }

        it 'must be ok' do
          expect { subject }.to_not raise_error
        end
      end

      context 'as a nil specimen' do
        let(:specimen_class) { nil.class }

        it 'must raise an error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'as a arbitrary value' do
        let(:specimen_class) { 'foobar'.class }

        it 'must raise an error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end
    end
  end

  describe 'selecting the population to keep' do
    subject do
      world.population_to_keep
    end

    let!(:world) do
      Gemnetic::World.new(
        specimen_class,
        population_size: population_size,
        population_keep: population_keep,
        initialize_population: false
        )
    end
    let!(:specimen_class) { MockedSpecimen }
    let(:population_size) { 5 }
    let(:population_keep) { 2 }
    let!(:mocked_specimen1) do
      mocked = MockedSpecimen.new
      allow(mocked).to receive(:evaluate).and_return(100)
      mocked
    end
    let!(:mocked_specimen2) do
      mocked = MockedSpecimen.new
      allow(mocked).to receive(:evaluate).and_return(50)
      mocked
    end

    before do
      mocked_population = []
      3.times do |index|
        mocked = MockedSpecimen.new
        allow(mocked).to receive(:evaluate).and_return(rand(1..10))
        mocked_population.push(mocked)
      end
      world.population = mocked_population + [mocked_specimen1, mocked_specimen2]
    end

    it 'must select only the amount of population to keep' do
      expect(subject.count).to eq population_keep
    end

    it 'must select the best specimen only' do
      expect(subject).to contain_exactly(mocked_specimen1, mocked_specimen2)
    end
  end
end
