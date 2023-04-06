require 'rails_helper'

RSpec.describe 'Entries Requests' do

  describe 'GET /v1/journals/:journal_id/entries' do
    let(:journal) { Journal.all.first }

    it 'returns all entries for the journal' do
      get "/v1/journals/#{journal.id}/entries"

      entries = json['entries']
      expect(entries.length).to eq(10)
      expect(entries.map {|x| x['journal_id']}).to all(eq(journal.id))
    end
  end

  describe 'GET /v1/journals/:journal_id/entries/:id' do
    let(:entry) { Entry.all.first }

    it 'returns the correct journal' do
      get "/v1/journals/#{entry.journal_id}/entries/#{entry.id}"

      expect(json['entry']['id']).to eq(entry.id)
      expect(json['entry']['journal_id']).to eq(entry.journal_id)
    end
  end
end
