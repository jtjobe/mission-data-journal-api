class Author

  def self.seeds
    [
      {
        name: 'Rando',
        klass: Faker::Quote,
        methods: [:famous_last_words, :jack_handey, :matz, :most_interesting_man_in_the_world]
      },
      {
        name: 'Chiquito',
        klass: Faker::Quotes::Chiquito,
        methods: [:joke, :sentence]
      },
      {
        name: 'Rajnikanth',
        klass: Faker::Quotes::Rajnikanth,
        methods: [:joke]
      },
      {
        name: 'Shakespeare',
        klass: Faker::Quotes::Shakespeare, 
        methods: [:hamlet_quote, :as_you_like_it_quote, :king_richard_iii_quote]
      }
    ]
  end
end
