def new_deck
  {
    hearts: %w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King),
    spades: %w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King),
    diamonds: %w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King),
    clubs: %w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King)
  }
end

deck = new_deck
player = []
dealer = []
GAME_TARGET = 21
DEALER_MIN = 17
scores = { 'player' => 0, 'dealer' => 0 }
winner = ''

def deal(deck, player)
  suit = deck.keys.sample
  value = deck[suit].sample
  player << { suit: suit.to_s, value: value.to_s }
  deck[suit].delete(value)
end

def total(player)
  total = 0
  values = player.map { |card| card[:value] }
  values.each do |v|
    case v
    when 'Jack', 'Queen', 'King'
      total += 10
    when 'Ace'
      total += 11
    else
      total += v.to_i
    end
  end
  number_aces = values.count('Ace')
  total -= number_aces * 10 if total > GAME_TARGET
  total
end

def display_cards(player, dealer, reveal = false)
  player_hand = player.map { |card| "#{card[:value]} of #{card[:suit]}" }
  prompt "Player has: #{player_hand.join(' and ')}"

  dealer_hand = dealer.map { |card| "#{card[:value]} of #{card[:suit]}" }
  print "---> Dealer has: #{dealer_hand[0]}"
  if reveal == true
    print " and #{dealer_hand[1..-1].join(' and ')}"
  end
  puts
  puts
end

def show_final_scores(player, dealer)
  prompt "Your final score is #{total(player)}"
  prompt "Dealers final score is #{total(dealer)}"
end

def prompt(msg)
  print "--->  #{msg}"
  puts
end

def busted?(player)
  total(player) > GAME_TARGET
end

def scored_target?(player)
  total(player) == GAME_TARGET
end

def setup(deck, player, dealer)
  2.times do
    deal(deck, player)
    deal(deck, dealer)
  end
  display_cards(player, dealer)
end

def player_turn(deck, player, dealer)
  answer = nil
  player_total = 0
  loop do
    prompt "Hit or Stay?"
    answer = gets.chomp.downcase
    next if answer =~ /\A[^hs]/
    break if answer =~ /(\A^s|'stay')/
    deal(deck, player)
    display_cards(player, dealer, false)
    player_total = total(player)
    break if player_total > GAME_TARGET || player_total == GAME_TARGET
  end
end

def dealer_turn(deck, dealer, player)
  loop do
    display_cards(player, dealer, true)
    break if total(dealer) > DEALER_MIN
    deal(deck, dealer)
  end
end

loop do
  setup(deck, player, dealer)
  player_turn(deck, player, dealer)
  player_total = total(player)

  if player_total > 21
    winner = 'dealer'
  elsif player_total == 21
    winner = 'player'
  else
    dealer_turn(deck, dealer, player)
  end
  dealer_total = total(dealer)

  unless player_total > GAME_TARGET
    if dealer_total == player_total
      winner = 'draw'
    elsif dealer_total == GAME_TARGET
      winner = 'dealer'
    elsif dealer_total > GAME_TARGET
      winner = 'player'
    else
      winner = player_total > dealer_total ? 'player' : 'dealer'
    end
  end

  puts
  show_final_scores(player, dealer)

  if winner == 'draw'
    prompt("It's a draw")
  else
    prompt("#{winner.capitalize} wins!")
    scores[winner] += 1
  end

  puts "Would you like to play again?"
  again = gets.chomp.downcase
  break if again =~ /\A[^y]/
  deck = new_deck
  player = []
  dealer = []
end

puts "Goodbye!"
prompt("Final scores are:")
prompt("You scored #{scores['player']}, dealer scored #{scores['dealer']}")
puts
