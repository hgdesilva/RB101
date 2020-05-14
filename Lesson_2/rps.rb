system("clear")
options = %w(rock paper scissors spock lizard)
options_letters = ['r', 'p', 's', 'sp', 'l']

combinations = {
  'rock' => ['scissors', 'lizard'],
  'paper' => ['rock', 'spock'],
  'scissors' => ['paper', 'lizard'],
  'spock' => ['rock', 'scissors'],
  'lizard' => ['paper', 'spock']
}

score_store = {
  'user' => 0,
  'computer' => 0,
  'draw' => 0
}
def prompt(message)
  puts "=> #{message}"
end

def display_choices(user_choice, computer_choice)
  prompt("You chose #{user_choice}, the computer chose #{computer_choice} ")
end

def outcome(user_choice, computer_choice, combinations)
  if combinations[user_choice].include?(computer_choice)
    'user'
  elsif combinations [computer_choice].include?(user_choice)
    'computer'
  else
    'draw'
  end
end

def update_score(result, score_store)
  score_store[result] += 1
end

def display_outcome(result, score_store)
  case result
  when 'user'
    prompt("You won! Awesome!")
  when 'computer'
    prompt("Computer won!")
  when 'draw'
    prompt("It's a draw!")
  end
  prompt("Your score is #{score_store['user']}")
  prompt("Computer's score is #{score_store['computer']}")
end

def display_summary(score_store)
  rounds = score_store.values.inject(&:+)
  if rounds > 0
    prompt("After #{rounds} round(s)...the results are:")
    prompt("You score #{score_store['user']}")
    prompt("the computer scored #{score_store['computer']}")
    if score_store['draw'] > 0
      prompt("with #{score_store['draw']} draw(s)")
    end
    puts
  else
    prompt("Bye!")
  end
end

def valid_input?(user_choice, options, options_letters)
  options.include?(user_choice) || options_letters.include?(user_choice)
end

def standardize_choice(user_choice, options, option_letters)
  if options.include?(user_choice)
    user_choice
  else
    options[option_letters.index(user_choice)]
  end
end

prompt("Welcome")
puts "-" * 45
loop do
  loop do
    prompt("Please enter #{options.join(', ')}")
    prompt("or #{options_letters.join(', ')} respectively")
    puts
    prompt("You can quit at any time by pressing q or Q")
    user_choice = gets.chomp.downcase

    break if user_choice == 'q'
    computer_choice = options.sample

    if valid_input?(user_choice, options, options_letters)
      user_choice = standardize_choice(user_choice, options, options_letters)
      system "clear"
      display_choices(user_choice, computer_choice)
      result = outcome(user_choice, computer_choice, combinations)
      update_score(result, score_store)
      display_outcome(result, score_store)
      puts
      break if score_store.values.inject(&:+) == 5
    else
      prompt("That didn't seem right...")
    end
  end

  display_summary(score_store)
  puts("Another round? Type Yes, Y or y to try again")
  break unless gets.chomp.downcase.start_with?('y')
end

prompt("GOODBYE !!")
