class Game
  
  def initialize(deck_number, players)
    raise 'must be at least one deck' if deck_number<1
    raise 'must be at least one player' if players.blank?
    @players = []
    @players << players
    @players.each{|player| player.start_game}
    @deck = []
    @dealer_hand = []
    deck_number.times do
      ['spade', 'diamond', 'heart', 'club'].each do |suit|
        Card.find_each do |card|
          @deck.push({name: "#{card.name} #{suit}", cost: card.cost})
        end
      end
    end
  end
  
  def deck
    @deck
  end
  
  def start_game
    raise 'game is already started' unless @dealer_hand.blank?
    @deck.shuffle!
    @players.each do |player|
      2.times {self.draw player}
    end
    2.times {@dealer_hand.push @deck.pop}
    {dealer_card: @dealer_hand.first}
  end
  
  def end_game
    if @players.all?{|player| player.status == :stop}
      return {status: 'Не все игроки закончили'}
    end
    while (@dealer_hand.inject(0){|sum,card| sum+card[:cost]} < 17) do
      @dealer_hand.push @deck.pop
    end
    dealer_score = @dealer_hand.inject(0){|sum,card| sum+card[:cost]}
    dealer_score = 0 if dealer_score > 21
    winner_player = @players.max{|player1, player2| player1.score <=> player2.score}
    all_cards = [{nickname: 'dealer', cards: {score: dealer_score, hand: @dealer_hand}}]
    all_cards << @players.map{|player|{nickname: player.nickname, hand: player.look_hand}}
    if winner_player.score > dealer_score
      winner_player.update!(total_score: winner_player.total_score+winner_player.score)
      return {status: "Победил #{winner_player.nickname}", cards: all_cards}
    else
      return {status: 'Победило казино', cards: all_cards}
    end
  end
  
  def draw user
    raise 'Вы больше не можете брать карты' if user.status == :stop
    card = user.draw_card(@deck.pop)
    user.stop if user.score == 0
    card
  end
  
  def deck_size
    @deck.size
  end
  
  
end
