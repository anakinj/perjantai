describe Perjantai::API::Lottery do
  include Rack::Test::Methods

  let(:app) { described_class }

  context 'POST /lottery' do
    subject(:response) { post '/lottery', name: 'New lottery' }

    it 'responds with 201' do
      expect(response.status).to eq 201
    end

    it 'stores the lottery into the store' do
    end
  end

  context 'GET /lottery' do
    let(:id) { nil }
    subject(:response) { get '/lottery', id: id }

    context 'when lottery exists' do
      let(:id) do
        post '/lottery', name: 'New lottery'
        JSON.parse(last_response.body)['id']
      end

      it 'response with 200 and data' do
        expect(response.status).to eq 200
        expect(JSON.parse(response.body)).to eq('id' => id, 'name' => 'New lottery')
      end
    end
  end
end
