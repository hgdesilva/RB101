require 'yaml'

MESSAGES = YAML.load_file('calculator_messages.yml')
# MESSAGES.each do |k,v|
#   puts"K E Y is #{k},  V A L U E is #{v}"
#   end
LANGUAGE = 'en'
def messages(key, lang=en)
 MESSAGES[lang][key]
end

def prompt(key)
  message = messages(key, LANGUAGE)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i != 0
end



def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2' then "Subtracting"
  when '3' then 'Multiplying'
  when '4' then 'Dividing'
  end
end

prompt('welcome')
name = ''
loop do
  name = Kernel.gets().chomp()
  if name.empty?()
    prompt('valid_name')
  else
    break
  end
end

puts("=>Hi #{name}!")

loop do # main loop
  number1 = ''
  loop do
    prompt('first_number_prompt')
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt('not_valid')
    end
  end

  number2 = ''
  loop do
    prompt('second_number_prompt')
    number2 = Kernel.gets().chomp()
    if valid_number?(number2)
      break
    else
      prompt('not_valid')
    end
  end

  operator_prompt = <<-HIRAN

  HIRAN
  prompt('operator_prompt')
  operator = ''
  loop do
      operator = Kernel.gets().chomp()
      if %w(1 2 3 4).include?(operator)
       break
      else
        prompt("Please enter 1, 2, 3, or 4")
      end
     end

  print("=>#{operation_to_message(operator)} " )
  puts("the two numbers")

  result =  case operator
            when '1'
      number1.to_i() + number2.to_i()
            when '2'
      number1.to_i() - number2.to_i()
            when '3'
      number1.to_i() * number2.to_i()
            when '4'
      number1.to_f() / number2.to_f()
            end

  prompt('result') 
  puts " #{result}"
  prompt('again?')
  response = Kernel.gets().chomp()
  break unless response.downcase().start_with?('y')
end

prompt('goodbye')

