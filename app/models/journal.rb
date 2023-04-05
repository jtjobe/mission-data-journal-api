#
# TODO: Inherit from ApplicationRecord to leverage ActiveRecord ORM
#
# (But challenge said not to persist data and this was fun to build out in-memory CRUD methods on my own :) - although I would never, ever do this outside of an exercise / in a real application...¯\_(ツ)_/¯)
#
class Journal

  # DIY in memory CRUD class methods...

  def self.load_seeds
    seed_data = [
      { name: "Shakespeare's Journal", id: SecureRandom.uuid },
      { name: "Chiquito's Journal", id: SecureRandom.uuid },
      { name: "Rajnikanth's Journal", id: SecureRandom.uuid },
      { name: "Rando's Journal", id: SecureRandom.uuid }
    ]

    seed_data.map { |data| new(data) }
  end

  def self.all
    @all ||= load_seeds
  end

  def self.all=(records)
    @all = records
  end

  def self.create(params)
    new({ name: params[:name] }).tap { |new_record| all.push(new_record) }
  end

  def self.find(id)
    all.find { |journal| journal.id == id }
  end

  def self.find_all_other_records(id)
    all.select { |journal| journal.id != id }
  end

  # Initialize and instance methods below

  attr_reader :id
  attr_accessor :name

  def initialize(hash)
    @id = SecureRandom.uuid
    @name = hash[:name]
  end

  def update(params)
    tap do |record|
      record.name = params[:name]
      Journal.all = [record, Journal.find_all_other_records(record.id)].flatten
    end
  end

  def destroy
    Journal.all = Journal.find_all_other_records(id)
    self
  end

  def fakers
    [
      Faker::Quote,
      Faker::Quotes::Chiquito,
      Faker::Quotes::Rajnikanth,
      Faker::Quotes::Shakespeare
    ]
  end
end
