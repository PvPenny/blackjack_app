require 'rails_helper'

RSpec.describe Api::BlackjackController, type: :controller do
  before do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
    Card.seed
    @user = FactoryGirl.create(:user)
  end
  
  it 'should raise error if not auth', skip_before: true do
    post :connect
    response.status.should eql 401
  end
  
  describe "game started?" do
    it 'should not start before start' do
      sign_in @user
      get :game_status
      response.body['status'].should eql 'Игра не начата'
    end

  end
  
end
