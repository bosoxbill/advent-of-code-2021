INPUT = 'input.txt'
DEBUG = false

def debug_print(stringish)
  puts stringish if DEBUG
end

@map = Array.new

file_lines = File.readlines(INPUT)
file_lines.each do |line|
  @map << line.chomp.chars.map(&:to_i)
end

@low_points = Hash.new
@basins = Hash.new
@visited = Hash.new

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

# PARTE THE SECONDE
def adjacent(x, y)
  adj = Array.new
  [[0, -1], [0, 1], [-1, 0], [1, 0]].each do |dx, dy|
    new_x = x + dx
    new_y = y + dy
    if new_x >= 0 && new_x < @map.first.count && new_y >= 0 && new_y < @map.count
      adj << [new_x, new_y]
    end
  end
  return adj
end

def define_basin(acc, x, y)
  return if @visited[[x, y]]
  return if @map[y][x] == 9
  @visited[[x,y]] = true
  acc << [x, y]

  adjacent(x, y).each do |(new_x, new_y)|
    define_basin(acc, new_x, new_y)
  end

  acc
end
@basin_size = Array.new
@low_points.keys.each do |(x, y)|
  @visited = Hash.new
  @basins[[x, y]] = define_basin(Array.new, x, y)
  @basin_size << @basins[[x, y]].count
end

pp @basins.values.sort{|a, b| b.count <=> a.count}[0..2].inject(1) {|acc, b| acc *= b.count }
