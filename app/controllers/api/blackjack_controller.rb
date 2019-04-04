module Api
  class BlackjackController < ApplicationController
  
    before_action :authenticate_user!
    before_action :game_status, except: [:start_game]
    
    def game_status
      render json: {status: 'Игра не начата'}, status: 422 and return if @game.nil?
      {status: 'Идет игра'}
    end
  
    def player_count
      @players.count
    end
  
    def start_game
      @game = Game.new(1, current_user)
      @game.start_game
      render json: {status: 'Игра началась'}
    end
  
    def draw
      render json: @game.draw(current_user)
    end
  
    def stop
      result = @game.end_game
      @game = nil
      render json: result
    end
  
  end
end
