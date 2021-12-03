INPUT = 'input.txt'

positions_and_counts = Hash.new{|h,k| h[k] = Hash.new} 

File.readlines(INPUT).each do |line|
  chars = line.chomp.chars.reverse
  chars.each_with_index do |char, index|
    positions_and_counts[index][char.to_i] ||= 0
    positions_and_counts[index][char.to_i] += 1
  end
end

pp positions_and_counts
pp ""

gamma = Array.new
epsilon = Array.new
positions_and_counts.each do |(index, counts_hash)|
  if counts_hash[0] > counts_hash[1]
    gamma.unshift(0)
    epsilon.unshift(1)
  else
    gamma.unshift(1)
    epsilon.unshift(0)
  end
end
pp "  " + gamma.join
pp "x " + epsilon.join
pp "-----------------"
pp gamma.join.to_i(2) * epsilon.join.to_i(2)
