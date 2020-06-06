# Problem 1
# return value is [1,2,3]

# Problem 2
# count treats the blocks return as a counter of 'truthy' values

# Problem 3
# reject will return [1,2,3]

# Problem 4
# {'a' => 'ant', 'b' => 'bear', 'c' => 'cat'}

# Problem 5
# Hash#shift removes the first key-value pair and returns it as an 2-item array OR the default object if the hash is empty

# Problem 6
# .pop.size will return 11

# Problem 7
# any? returns true if anything in block evalutes to true

# Problem 8
# Array#take is not destructuve - see docs

# Problem 9
# [nil, bear]

# Problem 10
# [1, nil, nil]

# # ADDITIONAL PRACTICE

# Problem 1
def flinstones(arr)
  output = Hash.new
  arr.each_with_index do |el, idx|
    output[el] = idx
  end
  output
end

#dangerous is elements aren't unique as Array#index looks for first occurence
def flinstones(arr)
  arr.each_with_object({}) do |el,memo|
    memo[el] = arr.index(el)
  end
end

p flinstones(['Fred', 'Barney', 'Wilma', 'Betty', 'Pebbles', 'BamBam'])

# Problem 2
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
total = 0
ages.each{|_,v| total += v}
p total

p ages.values.inject(:+)

#Problem 3
ages = {"Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10}

# returns new hash
ages.reject {|_,v| v >= 100}

# keep_if and select! return same hash

# Problem 4
ages = {"Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot"=> 237 }

p ages.values.min

# Problem 5
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.index {|v| v[0..1] == "Be"}

# Problem 6
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.map!{|v| v[0,3]}

# Problem 7
statement = "The Flinstones Rock"
# counter = Hash.new(0)
# statement.chars.each{|chr| counter[chr] += 1}
# p counter

counter = {}
letters = ("a".."z").to_a + ("A".."Z").to_a
letters.each do |letter|
  counter[letter] = statement.count(letter) if statement.count(letter) > 0
end
p counter

# Problem 8

# 1 3
# 1 2 

# Problem 9
words = "the Flinstones rock"

# def titlesize(str)
#   str.split.map{|w| w.capitalize}.join(" ")
# end

def titlesize(str)
  str.split.each_with_object([]){|w,output| output << w.capitalize}.join(" ")
end

def titlesize(str)
  str.split.inject([]){|output, w| output << w.capitalize; output}.join(" ")
end

puts titlesize(words)

# Problem 10
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do|k,v|
  age_group = case v["age"]
    when 1..17
    "kid"  
  when 18..65
    "adult"
  else
    "senior"
  end

  v["age_group"] = age_group
end

p munsters