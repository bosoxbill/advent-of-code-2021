INPUT = 'input.txt'

@numbers = Array.new
@boards = Array.new

file_lines = File.readlines(INPUT)
@numbers = file_lines.shift.chomp.split(',').collect(&:to_i)
board = nil
row = 0
file_lines.each do |line|
  if line.chomp == ''
    @boards << board if board
    board = Hash.new
    row = 0
    next
  end
  board[:cols] ||= Hash.new
  board[:rows] ||= Hash.new
  line.chomp.split(' ').each_with_index do |number, index|
    position = Hash.new
    position[:number] = number.to_i
    position[:chosen] = false
    board[:cols][index] ||= Array.new
    board[:cols][index] << position
    board[:rows][row] ||= Array.new
    board[:rows][row] << position
  end
  row += 1
end
@boards << board

def process_position(position, number)
  if position[:number] == number
    position[:chosen] = true
  end
  return position[:chosen]
end

def check_win(position_array)
  position_array.length == position_array.count{|pos| pos[:chosen] == true}
end


@last_num = nil
@winning_board = nil
@winner = false
@numbers.each do |number|
  next if @winner
  @last_num = number
  #find the number in each board
  @boards.each do |board|
    next if @winner
    @winning_board = board
    board[:cols].each do |col_idx, position_arr|
      position_arr.each do |position|
        next if @winner
        if process_position(position, number)
          @winner = check_win(board[:cols][col_idx])
        end
      end
    end
    board[:rows].each do |row_idx, position_arr|
      position_arr.each do |position|
        next if @winner
        if process_position(position, number)
          @winner = check_win(board[:rows][row_idx])
        end
      end
    end
  end
end

puts @winner
pp @winning_board
puts 'won at'
puts @last_num

#score it
unmarked_score = @winning_board[:rows].reduce(0) do |acc, row|
  position_arr = row[1]
  losers = position_arr.select{|pos| pos[:chosen] == false}
  acc += losers.sum{|pos| pos[:number]}
end

pp unmarked_score * @last_num
