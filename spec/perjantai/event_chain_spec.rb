describe Perjantai::EventChain do
  let(:instance) { described_class.new(id) }
  let(:id)       { SecureRandom.uuid }

  context 'when data is added and read' do
    before do
      instance.add_link(value: 1)
      instance.add_link(value: 2)
    end

    it 'returns it in the correct order' do
      vals = []
      instance.each do |data|
        vals << data[:value]
      end

      expect(vals).to eq([1, 2])
    end
  end
end
