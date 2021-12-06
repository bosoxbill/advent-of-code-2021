INPUT = 'input.txt'
GRID_SIZE = 1000

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

count = 0
@lines.each do |(x1, y1, x2, y2)|
  next unless x1 == x2 || y1 == y2
  sorted_x = [x1, x2].sort
  sorted_y = [y1, y2].sort
  count += 1
  (sorted_x[0]..sorted_x[1]).each do |x|
    (sorted_y[0]..sorted_y[1]).each do |y|
      @board[y][x] += 1
    end
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
