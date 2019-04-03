require 'rails_helper'
require 'devise'



RSpec.describe User, type: :model do

  before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end
  
  it 'should show leaderboard' do
    20.times{FactoryGirl.create(:user, {total_score: Random.rand(1000)})}
    leaderboard = User.leaderboard
    leaderboard.size.should eql 10
    leaderboard.each_with_index do |player, index|
      player[:score].should be > leaderboard[index+1][:score] if leaderboard[index+1].present?
    end
  end
  
end
