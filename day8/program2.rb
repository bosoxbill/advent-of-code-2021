INPUT = 'test1.txt'
DEBUG = false

@counts_and_numbers = {
 2 => 1,
 3 => 7,
 4 => 4,
 7 => 8
}

def debug_print(stringish)
  puts stringish if DEBUG
end

@data = Hash.new
File.readlines(INPUT).each_with_index do |line, index|
  input_codes, output = line.split('|')
  @data[index] ||= Hash.new
  @data[index][:outputs] ||= Hash.new
  @data[index][:outputs][:raw] = output.chomp.split(' ')
  @data[index][:outputs][:swaps] ||= Hash.new
  @data[index][:inputs] ||= Hash.new
  @data[index][:inputs][:raw] = input_codes.chomp.split(' ')
  @data[index][:inputs][:swaps] ||= Hash.new
end

def swap(hash, str)
  chars = str.chars.length
  return unless @counts_and_numbers.keys.include?(chars)
  hash[:swaps][str] = @counts_and_numbers[chars]
  pp hash[:swaps]
end

@data.each do |_x, ins_and_outs_and_what_have_yous|
  puts ''
  ins_and_outs_and_what_have_yous[:outputs][:raw].each do |output| 
    swap(ins_and_outs_and_what_have_yous[:outputs], output)
  end
  ins_and_outs_and_what_have_yous[:inputs][:raw].each do |input|
    swap(ins_and_outs_and_what_have_yous[:inputs], input)
  end
end

# 6 chars is either a 0, 6, or a 9...
#   ...9 or 0 if it has the same chars as a 7
#   ...6 if it does not
# 5 chars is either a 2, 3, or a 5...
#   ...3 if it has the same chars as a 7 or a 1
#   ...5 if it's missing just one bit from a 6

#9 has all of 4 and 3
#8 is a gime
#7 is a gimme
#6 all of 5 plus one extra bit
#5 is one less than 6
#4 is a gimme
#3 has all of 7
#2 is left
#1 is a gimme
#0 is a six-char that doesn't match 6 or 9
zero = one = two = three = four = five = nil
six = seven = eight = nine = nil
rules = {
  one: ->(num) { num.chars.count == 2 },
  four: ->(num) { num.chars.count == 4 },
  seven: ->(num) { num.chars.count == 3 },
  eight: ->(num) { num.chars.count == 7 },
  nine: ->(num, four) { num.chars.count == 6 && four.chars.all?{|c| num.chars.include?(c) }},
  three: ->(num, one) { num.chars.count == 5 && one.chars.all?{|c| num.chars.include?(c)  }},
  five: ->(num) { num.chars.count == 5 && true },
  six: ->(num, one) { num.chars.count == 6 && (num.chars & one.chars).length == 1 },
  zero: ->(num, four, one) { num.chars.count == 6 && one.chars.all?{|c| num.chars.include?(c)} && (num.chars & one.chars).length == 1 },
  two: ->(num) { true }
}

pp rules
