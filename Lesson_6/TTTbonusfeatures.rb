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

# def joinor(arr, delimiter=', ', word='or')
#   case arr.size
#   when 0 then ''
#   when 1 then arr.first
#   when 2 then arr.join(" #{word} ")
#   else
#     arr[-1] = "#{word} #{arr.last}"
#     arr.join(delimiter)
#   end
# end

puts joinor([1,2,3], 'or', ',')
puts joinor([1, 2, 3], ', ', 'and')