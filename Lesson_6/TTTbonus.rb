require 'pry'

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're an #{PLAYER_MARKER}, the computer is #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]} "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals
SCORE = {'Player' => 0, 'Computer' => 0}
player = nil
players = ['computer', 'you']

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(*args)
  output = ''
  arr = args[0]
  delim = args[1] == nil ? ', ' : args[1]
  andor = args[2] == nil ? 'or' : args[2]
  if arr.size == 1
    output = arr.first
  elsif arr.size == 2
    output = arr[0].to_s + " #{andor} " + arr[1].to_s
  else
    output = arr[0..-2].join("#{delim}") + "#{delim}#{andor} " + arr.last.to_s
  end
end



def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    if empty_squares(brd).include?(square)
      break
    else
      prompt "Sorry, that's not a valid choice."
    end
  end
  brd[square] = PLAYER_MARKER
end


def target_square(brd, marker)
  target = nil
  WINNING_LINES.each do |line|
    arr = line.map {|num| brd[num]} 
    if arr.include?(" ") && arr.count(marker) == 2
      target = line[arr.index(" ")]
    end
  end
  target
end

def target?(brd, marker)
  !!target_square(brd, marker)
end


def computer_places_piece!(brd)
  if target?(brd, COMPUTER_MARKER)
  square = target_square(brd, COMPUTER_MARKER)
  elsif target?(brd, PLAYER_MARKER)
    square = target_square(brd, PLAYER_MARKER)
  elsif brd[5] == INITIAL_MARKER
    square = 5
  else
    square = empty_squares(brd).sample
  end
    brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

loop do
  puts "Choose who starts..."
  puts "1 for the computer"
  puts "2 for YOU!"
  puts "3 random choice of either computer or YOU!"
  player = gets.chomp.to_i
  break if [1,2,3].include?(player)
  puts "Please enter 1,2 or 3."
end 
  player == 3 ? player = players.sample : player = players[player-1]
  puts "player is ....#{player}"
  sleep(1)

def play (brd,player)
  player == 'you' ? player_places_piece!(brd) : computer_places_piece!(brd)
end


def change_player(player)
  player == 'you' ? player = 'computer' : player = 'you'
end

loop do
  board = initialize_board

  loop do
    display_board(board)
    play(board, player)
    player = change_player(player)
    break if someone_won?(board) || board_full?(board)
  end
   
    display_board(board)
    if someone_won?(board)
      SCORE[detect_winner(board)] += 1
      puts "#{detect_winner(board)} won !"
      sleep(1)
    else
      puts "It's a tie !"
      sleep(0.6)
    end
    break if SCORE.values.include?(5)
end

winner = SCORE.key(5)
prompt "#{winner} won!"
