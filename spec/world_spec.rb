RSpec.describe Gemnetic::World do
  describe 'initializing the world' do
    subject { Gemnetic::World.new(specimen_class, params) }
    let(:params) { {} }
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


end
