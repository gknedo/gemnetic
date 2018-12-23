RSpec.describe Gemnetic::Specimen do
  let!(:specimen) { MockedSpecimen.new }

  describe 'the mix method' do
    subject { specimen.mix(MockedSpecimen.new) }

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
end
