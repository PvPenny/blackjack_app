class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  
  def self.leaderboard
    leaders = self.order(total_score: :desc).first(10)
    result = []
    leaders.each { |player| result.push({nickname: player.nickname, score: player.total_score}) }
    result
  end
  
  def start_game
    @hand = []
    @stop = false
  end
  
  def status
    if @stop
      return :stop
    else
      return :drawing
    end
  end
  
  
  def look_hand
    {score: self.score,hand: @hand}
  end
  
  def score
    raise 'Вы не в игре' if @hand.blank?
    score = @hand.inject(0){|score, card| score + card[:cost]}
    score = 0 if score > 21
    score
  end
  
  def draw_card card
    @hand.push(card)
    look_hand
  end
  
  def stop
    @stop = true
  end
  
end
