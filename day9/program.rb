INPUT = 'input.txt'
DEBUG = false

def debug_print(stringish)
  puts stringish if DEBUG
end

@map = Array.new
@low_points = Hash.new
file_lines = File.readlines(INPUT)
file_lines.each do |line|
  @map << line.chomp.chars.map(&:to_i)
end

@width = @map.first.count
@height = @map.count

def surrounded_by_higher(depth, x, y)
  # north
  if(y - 1 >= 0)
    if(@map[y-1][x] <= depth)
      return false
    end
  end
  # south
  if(y + 1 < @map.count)
    if(@map[y+1][x] <= depth)
      return false
    end
  end
  # east
  if(x + 1 < @map.first.count)
    if(@map[y][x+1] <= depth)
      return false
    end
  end
  # west
  if(x - 1 >= 0)
    if(@map[y][x-1] <= depth)
      return false
    end
  end
  return true
end

@map.each_with_index do |row, y_idx|
  row.each_with_index do |depth, x_idx|
    if surrounded_by_higher(depth, x_idx, y_idx)
      @low_points[[x_idx, y_idx]] = depth
    end
  end
end

pp @low_points.values.sum + @low_points.values.count
