class Api::LeaderboardController < ApplicationController
  def index
    render json: User.leaderboard
  end
end
