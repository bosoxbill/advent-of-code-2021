INPUT = 'input.txt'
DEBUG = false

def debug_print(stringish)
  puts stringish if DEBUG
end

file_lines = File.readlines(INPUT)
@crab_positions = file_lines.first.split(',').collect(&:to_i)

crab_positions_frequency = @crab_positions.inject(Hash.new(0)) do |hash, crab_pos|
  hash[crab_pos] += 1
  hash
end

@mean = @crab_positions.sum / @crab_positions.length
max = crab_positions_frequency.values.max
modes = crab_positions_frequency.select{|_k, count| count == max }
@mode = modes.first[0]

#neither mean nor mode get me there... which surprised me

min_e = 999999999999999
@dist = Hash.new()
(0..1000).each do |num|
  @dist[num] ||= Hash.new
  @dist[num][:total] ||= 0
  @crab_positions.each do |position|
    distance = (position - num).abs
    @dist[num][position] ||= Hash.new
    if @dist[num][position][:energy]
      @dist[num][position][:count] += 1
    else
      @dist[num][position][:energy] = 0.upto((position - num).abs).sum
      @dist[num][position][:count] = 1
    end
    @dist[num][:total] += @dist[num][position][:energy]
  end
  if @dist[num][:total] < min_e
    min_e = @dist[num][:total]
  end
end

pp min_e
