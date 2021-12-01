INPUT = 'input.txt'

previous = nil
count = 0
entries = File.readlines(INPUT).collect{|x| x.to_i}

entries.each_with_index do |depth, index|
  depth_window = depth + (entries[index - 1]) + (entries[index - 2])
  if previous && depth_window > previous
    count += 1
  end
  previous = depth_window
end

puts count
