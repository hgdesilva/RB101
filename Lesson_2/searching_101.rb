ordinals = %w(1st 2nd 3rd 4th 5th last)
all_numbers = []
def prompt(msg)
  puts("=>#{msg}")
end

counter = 0
loop do
  break if counter > 5
  prompt("Enter the #{ordinals[counter]} number")
  number = gets.chomp
  if Integer(number, exception: false)
    all_numbers << number
    counter += 1
  else
    prompt("Please enter a whole number")
  end
end

included = all_numbers[0..-2].include?(all_numbers.last)
last_num = all_numbers.last

print"The number #{last_num} does#{included ? ' ' : ' not '}"
puts "appear in #{all_numbers[0..-2]}"
