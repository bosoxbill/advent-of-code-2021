INPUT = ENV['INPUT'] ? ENV['INPUT'] : 'input.txt'
DEBUG = ENV['DEBUG'] ? true : false

def debug_print(stringish)
  pp stringish if DEBUG
end

@grid = Array.new
@flashers = Hash.new{|h, k| h[k] = false}
@flash_count = 0

file_lines = File.readlines(INPUT)
file_lines.each do |line|
  @grid << line.chomp.chars.map(&:to_i)
end

def adjacent(x, y)
  adj = Array.new
  surroundings = Array.new
  (-1..1).each do |y|
    (-1..1).each do |x|
      surroundings << [x, y]
    end
  end
  surroundings.reject!{|element| element == [0,0]}
  surroundings.each do |(dx, dy)|
    new_x = x + dx
    new_y = y + dy
    if new_x >= 0 && new_x < @grid.first.count && new_y >= 0 && new_y < @grid.count
      adj << [new_x, new_y]
    end
  end
  return adj
end

def flash(grid, x, y)
  if grid[y][x] > 9
    @flashers[[x, y]] = true
    grid[y][x] = 0
    @flash_count += 1
    adjacent(x, y).each do |(new_x, new_y)|
      next if @flashers[[new_x, new_y]]
      grid[new_y][new_x] += 1
      flash(grid, new_x, new_y)
    end
  end
end

octopuses = @grid.count * @grid.first.count
loop_ctr = 0
while @flashers.values.count{|v| !!v} != octopuses
  loop_ctr += 1
  @flashers = Hash.new{|h, k| h[k] = false}
  @grid = @grid.map{|row| row.map {|octopus| octopus += 1}}

  @grid.each_with_index do |row, y_index|
    row.each_with_index do |_col, x_index|
      flash(@grid, x_index, y_index)
    end
  end
end

pp @grid

pp @flashers
puts "#{octopuses} total octopodae"

pp @flash_count

pp loop_ctr
