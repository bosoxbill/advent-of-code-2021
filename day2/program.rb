INPUT = 'input.txt'

depth = 0
horizontal = 0
File.readlines(INPUT).each do |line|
  operation, distance = line.split(' ')
  case operation
  when 'forward'
    horizontal += distance.to_i
  when 'down'
    depth += distance.to_i
  when 'up'
    depth -= distance.to_i
  end
end

puts depth * horizontal
