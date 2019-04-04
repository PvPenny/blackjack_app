Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    get 'leaderboard/index'
  end
  namespace :api do
    resources :cards
    namespace :blackjack do
      post 'draw'
      get 'game_status'
      post 'start_game'
      post 'stop'
    end
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
