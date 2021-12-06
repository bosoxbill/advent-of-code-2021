INPUT = 'input.txt'
DEBUG = false
GRID_SIZE = 1000

def debug_print(stringish)
  pp stringish if DEBUG
end

@board = Array.new
GRID_SIZE.times{|_x| @board << Array.new(GRID_SIZE,0)}

@lines = Array.new

file_lines = File.readlines(INPUT)
file_lines.each do |line|
  start, finish = line.chomp.split(' -> ')
  x1, y1 = start.split(',')
  x2, y2 = finish.split(',')
  @lines << [x1.to_i, y1.to_i, x2.to_i, y2.to_i]
end

@lines.each do |(x1, y1, x2, y2)|
  vertical, horizontal, south_west = false
  debug_print "(#{x1}, #{y1}, #{x2}, #{y2})"
  if x1 == x2
    debug_print "  vertical"
    vertical = true
    dist = (y2-y1).abs
  elsif y1 == y2
    debug_print "  horizontal"
    horizontal = true
    dist = (x2-x1).abs
  elsif (x2-x1)*(y2-y1) > 0
    debug_print "  south_westy"
    #gd math - line goes backwards
    south_west = true
    dist = (y2-y1).abs
  else
    debug_print "  north_westy"
    dist = (y2-y1).abs
  end
  debug_print "  dist: #{dist}"

  0.upto(dist) do |num|
    if vertical
      x = x1
      y = num + [y1, y2].min
    elsif horizontal
      x = num + [x1, x2].min
      y = y1
    elsif south_west
      x = num + [x1, x2].min
      y = num + [y1, y2].min
    else
      x = num + [x1, x2].min
      y = [y1, y2].max - num
    end
    debug_print "(#{x},#{y})"
    @board[y][x] += 1
  end
end

count = 0
@board.each do |row|
  row.each do |position|
    if position > 1
      count += 1
    end
  end
end

pp count

debug_print @board
