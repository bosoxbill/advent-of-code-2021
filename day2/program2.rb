INPUT = 'input.txt'

depth = 0
horizontal = 0
aim = 0
File.readlines(INPUT).each do |line|
  operation, distance_str = line.split(' ')
  distance = distance_str.to_i
  case operation
  when 'forward'
    horizontal += distance
    depth += aim * distance
  when 'down'
    aim += distance
  when 'up'
    aim -= distance
  end
end

puts depth * horizontal
