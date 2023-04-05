require 'rails_helper'

RSpec.describe 'Journals Requests' do

  describe 'GET /v1/journals' do

    it 'returns all journals' do
      get '/v1/journals'
      expect(json['journals']).to eq(Journal.all.as_json)
    end
  end

  describe 'POST /v1/journals' do
    let(:name) { 'SECRET JOURNAL - DO NOT READ' }

    it 'creates a new journal' do
      expect {
        post '/v1/journals', params: { name: name }
      }.to change { Journal.all.count }.by(+1)

      expect(json['journal']['name']).to eq(name)
    end
  end

  describe 'GET /v1/journals/:id' do
    let(:journal) { Journal.all.first }

    it 'returns the correct journal' do
      get "/v1/journals/#{journal.id}"
      expect(json['journal']).to eq(journal.as_json)
    end
  end

  describe 'PUT /v1/journals/:id' do
    let(:journal) { Journal.all.first }

    it 'updates the correct journal' do
      put "/v1/journals/#{journal.id}", params: { name: 'New Name' }
      expect(json['journal']['id']).to eq(journal.id)
      expect(json['journal']['name']).to_not eq(journal.id)
      expect(json['journal']['name']).to eq('New Name')
    end
  end

  describe 'DELETE /v1/journals/:id' do
    let(:journal) { Journal.all.first }

    it 'deletes the correct journal' do
      expect(Journal.all).to include(journal)

      expect {
        delete "/v1/journals/#{journal.id}"
      }.to change { Journal.all.count }.by(-1)

      expect(Journal.all).to_not include(journal)
    end
  end
end
