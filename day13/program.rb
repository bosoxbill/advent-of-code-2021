INPUT = ENV['INPUT'] ? ENV['INPUT'] : 'input.txt'
DEBUG = ENV['DEBUG'] ? true : false

def debug_print(stringish)
  pp stringish if DEBUG
end

@xs = Array.new
@ys = Array.new
@folds = Array.new

file_lines = File.readlines(INPUT)
file_lines.each do |line|
  next if line.chomp == ''
  matches = line.match(/^fold along (?<axis>x|y)=(?<scalar>\d+)$/)
  if matches
    @folds << [matches[:axis], matches[:scalar].to_i]
  else
    x, y = line.chomp.split(',')
    @xs << x.to_i
    @ys << y.to_i
  end
end

debug_print "X"
debug_print @xs
debug_print "\nY"
debug_print @ys
debug_print "\nFOLDS:"
debug_print @folds
raise "WTF" unless @xs.count == @ys.count

@grid = Array.new
@ys.max.times do 
  @grid << Array.new(@xs.max, false)
end

pp @grid
pp ''

@ys.each_with_index do |y, index|
  pp "putting true at #{y-1},#{@xs[index]}"
  @grid[y-1][@xs[index]] = true
end

pp @grid
pp ''

@folds.each do |(axis, scalar)|
  case axis
  when 'y'
    #fold right over left
    @grid.each_with_index do |row, y_index|
      row.each_with_index do |x, x_index|
        next unless x_index > scalar
        if @grid[y_index][x_index]
          dist = x_index - scalar
          @grid[y_index][scalar - dist] = true
        end
      end
    end
    @grid.each_with_index do |row, y_index|
      @grid[y_index] = @grid[y_index][scalar..-1]
    end
  when 'x'
    #fold bottom over top
    @grid.each_with_index do |row, y_index|
      next unless y_index > scalar
      row.each_with_index do |x, x_index|
        if @grid[y_index][x_index]
          dist = y_index - scalar
          @grid[scalar - dist][x_index] = true
        end
      end
    end
    @grid = @grid[scalar..-1]
  else
    raise "WTF"
  end
  break
end

pp @grid.sum{|row| row.filter{|x| x}.count }
