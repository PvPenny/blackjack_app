class Card < ApplicationRecord

  
  validates :name, presence: true, uniqueness: true
  validates :cost, presence: true, numericality: {less_than: 12, greater_than: 0}

  
  def self.seed
    card_data =
      [
        {
          name: 'Two',
          cost: 2,
        },
        {
          name: 'Three',
          cost: 3,
        },
        {
          name: 'Four',
          cost: 4,
        },
        {
          name: 'Five',
          cost: 5,
        },
        {
          name: 'Six',
          cost: 6,
        },
        {
          name: 'Sever',
          cost: 7,
        },
        {
          name: 'Eight',
          cost: 8,
        },
        {
          name: 'Nine',
          cost: 9,
        },
        {
          name: 'Ten',
          cost: 10,
        },
        {
          name: 'Jack',
          cost: 10,
        },
        {
          name: 'Queen',
          cost: 10,
        },
        {
          name: 'King',
          cost: 10,
        },
        {
          name: 'Ace',
          cost: 11,
        }
      ]
    card_data.each do |card_info|
      card = Card.find_or_create_by(name: card_info[:name])
      card.assign_attributes(card_info)
      card.save
    end
  end

end
