require 'rails_helper'
require 'database_cleaner'

RSpec.describe Game, type: :model do
  it 'should be more then one deck' do
    user = FactoryGirl.create(:user)
    user.start_game
    expect {Game.new(0,user)}.to raise_error
  end
  
  it 'should create 52-card deck' do
    @game.deck_size.should eql 52
  end

  before  do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
    Card.seed
    @user = FactoryGirl.create(:user)
    @game = Game.new(1,@user)
  end
  
 
  it 'should take 2 cards for each player and diller' do
    size = @game.deck_size
    @game.start_game
    (size - @game.deck_size ).should eql 4
  end
  
  it 'should not start game if dealer has cards' do
    @game.start_game
    expect {@game.start_game}.to raise_error
  end

  it 'should raise error after 21 points' do
    @game.start_game
    while @user.score > 0 do
      @game.draw @user
    end
    @user.score.should eql 0
    @user.status.should eql :stop
  end

  it 'should playing game' do
    @game.start_game
    @user.stop
    result = @game.end_game
    result[:status].should_not be_nil
  end
  

end
