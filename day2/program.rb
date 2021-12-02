INPUT = 'input.txt'

depth = 0
horizontal = 0
File.readlines(INPUT).each do |line|
  operation, distance = line.split(' ')
  case operation
  when 'forward'
    horizontal += distance
  when 'down'
    depth += distance
  when 'up'
    depth -= distance
  end
end

puts depth * horizontal
