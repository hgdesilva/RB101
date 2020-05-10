require 'yaml'

data = %w(principal apr duration)
inputs = {}

MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')

def messages(key)
  MESSAGES[key]
end

def prompt(ques)
  puts
  puts "==>#{messages(ques)}"
end

def valid?(value, d)
  return false if value.to_f <= 0 || value =~ /\D+\.?\D+/ || value =~ /\.$/
  case d
  when 'apr'
    Float(value, exception: false)
  when 'principal', 'duration'
    Integer(value, exception: false)
  end
end

def monthly_payment(pr, j, n)
  (pr * (j / (1 - (1 + j)**(-n)))).round(2)
end
# capture input in loop...
loop do
  data.each do |d|
    loop do
      prompt(d)
      value = gets.chomp
      if valid?(value, d)
        inputs[d] = (d == 'apr' ? value.to_f : inputs[d] = value.to_i)
        break
      else
        prompt('error')
      end
    end
  end

  puts "==>For a loan of #{inputs['principal']},
        borrowed for #{inputs['duration']} year(s)
        with an APR of #{inputs['apr']}"

  puts "==>Your monthly payment will be
  #{monthly_payment(inputs['principal'],
                    inputs['apr'] / 1200,
                    inputs['duration'] * 12)}"
  puts
  prompt('again')
  break unless gets.chomp.downcase.start_with?('y')
end

prompt('bye')
