VALID_CHOICES = %w(rock paper scissors lizard spock)
computer_score = 0
user_score = 0
def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'rock' && second == 'lizard')||
    (first == 'paper' && second == 'rock') ||
    (first == 'paper' && second == 'spock') ||
    (first == 'scissors' && second == 'paper') ||
    (first == 'scissors' && second == 'lizard') ||
    (first == 'lizard' && second == 'spock') ||
    (first == 'lizard' && second == 'paper') ||
    (first == 'spock' && second == 'scissors') ||
    (first == 'spock' && second == 'rock') 
end

def display_results(choice, computer_choice)
  Kernel.puts("You chose #{choice}, the computer chose #{computer_choice}!")
  if win?(choice, computer_choice)
    prompt('you won !!')
  elsif choice == computer_choice
    prompt('DRAW!!')
  else
    prompt("you lost !")
  end
end

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = Kernel.gets().chomp()
    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  display_results(choice, computer_choice)

  prompt("Do you want to play again?")
  break unless gets.chomp.downcase.start_with?("y")
end

prompt("Thank you for playing. GOODBYE!!")
