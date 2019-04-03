require 'rails_helper'

RSpec.describe Card, type: :model do
  before do
    @card = FactoryGirl.create(:card)
  end
  
  it 'should require name' do
    @card.cost = 11
    @card.name = nil
    @card.should_not be_valid
    @card.errors[:name].should_not be_nil
  end

  it 'should require cost' do
    @card.name = 'ace'
    @card.cost = nil
    @card.should_not be_valid
    @card.errors[:suit].should_not be_nil
  end
  
  it 'should be unique name' do
    Card.create!(name: 'ace', cost: 11)
    card = Card.new
    card.name = 'ace'
    card.cost = 11
    card.should_not be_valid
    card.errors[:name].should_not be_nil
  end
  
end
