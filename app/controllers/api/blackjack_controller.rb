module Api
  class BlackjackController < ApplicationController
  
    before_action :authenticate_user!
    before_action :game_started?, except: [:start_game, :connect]
    def game_status
      if @game.blank?
        status = 'Игра не начата'
      else
        status = 'Игра начата'
      end
      render json: {status: 'Игра начата'}
    end
  
    def player_count
      @players.count
    end
  
    def start_game
      return render json: {error: 'Отсутствуют игроки'}, status: :unprocessable_entity if @players.blank?
      return render json: {error: 'Вы не вошли в игру'}, status: :unprocessable_entity if @players.find{|player| player == current_user}.nil?
      deck_number = (@players.count/2 +1)
      @game = Game.new(deck_number, @players)
      render json: {status: 'Игра началась'}
    end
  
    def draw
      render json: @game.draw(current_user)
    end
  
    def stop
      render json: @game.stop
    end
  
    def connect
      @players = [] if @players.blank?
      if @players.find{|player| player == current_user}.nil?
        @players << current_user
        render json: {status: 'Вы присоединились к игре'}
      else
        render json: {status: 'Ошибка. Вы не моете присоединиться к игре'}
      end
    end

  end
end
