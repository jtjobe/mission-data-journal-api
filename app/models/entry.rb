#
# TODO: Inherit from ApplicationRecord to leverage ActiveRecord ORM
#
# (But challenge said not to persist data and this was fun to build out in-memory CRUD methods on my own :) - although I would never, ever do this outside of an exercise / in a real application...¯\_(ツ)_/¯)
#
class Entry

  def self.load_seeds
    Author.seeds.flat_map do |author_seed|
      klass = author_seed[:klass]
      journal = Journal.all.find { |journal| journal.name.include?(author_seed[:name]) }
      
      10.times.map do
        text = klass.send(author_seed[:methods].sample)
        random_num = (1...365).to_a.sample
        new(text: text, date: random_num.days.ago, journal_id: journal.id)
      end
    end
  end

  def self.all
    @all ||= load_seeds
  end

  def self.find(id)
    all.find { |entry| entry.id == id }
  end

  def self.all_for_journal(journal_id)
    all.select { |entry| entry.journal_id == journal_id }
  end

  attr_reader :id, :journal_id
  attr_accessor :text

  def initialize(params)
    @id = SecureRandom.uuid
    @journal_id = params[:journal_id]
    @date = params[:date] || Date.today
    @text = params[:text]
  end
end
