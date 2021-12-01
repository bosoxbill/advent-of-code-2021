INPUT = 'input.txt'

previous = nil
count = 0
File.readlines(INPUT).each do |line|
  depth = line.to_i
  if previous && depth > previous
    count += 1
  end
  previous = depth
end

puts count
