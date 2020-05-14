operations = [:+, :-, :*, :/, :%, :**]

def prompt(msg)
  puts("=> #{msg}")
end

def get_number(ordinal)
  prompt("Enter the #{ordinal} number:")
  number = gets.chomp.to_i
  number
end

def display_calcs(num1, num2, operations)
  operations.each do |op|
    result = num1.send(op, num2)
    puts "#{num1} #{op} #{num2} = #{result}"
  end
end

num1 = get_number("1st")
num2 = get_number("2nd")

display_calcs(num1, num2, operations)
