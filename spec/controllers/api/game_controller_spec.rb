require 'rails_helper'

RSpec.describe Api::BlackjackController, type: :controller do
  
  context "unlogin" do
    it 'should raise error if not auth', skip_before: true do
      post :start_game
      response.status.should eql 401
    end
  end
  
  context "loged" do
    before do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean
      Card.seed
      @user = FactoryGirl.create(:user)
      auth_headers = @user.create_new_auth_token
      request.headers.merge!(auth_headers)
    end

    it 'should not start before start' do
      post :draw
      response.status.should eql 422
    end
    
    it 'should draw card' do
      post :start_game
      post :draw
      response.status.should eql 200
    end
    
    it 'should stop game after game_stop' do
      post :start_game
      post :stop
      post :draw
      response.status.should eql 422
    end
    
  end
  
 
  
 
  


 
  
end
