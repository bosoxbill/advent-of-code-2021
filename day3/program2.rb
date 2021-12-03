INPUT = 'input.txt'

def count_em_up(set_of_chars)
  @positions_and_counts = Hash.new{|h,k| h[k] = Hash.new} 
  set_of_chars.each do |char_array|
    char_array.each_with_index do |char, c_index|
      @positions_and_counts[c_index][char.to_i] ||= 0
      @positions_and_counts[c_index][char.to_i] += 1
    end
  end
  puts "\nCounted..."
  pp @positions_and_counts
  puts ''
end

numbers = Array.new
@positions_and_counts = Hash.new{|h,k| h[k] = Hash.new} 

File.readlines(INPUT).each do |line|
  chars = line.chomp.chars.collect(&:to_i)
  numbers << chars
end
count_em_up(numbers)

oxygen_generator= numbers.clone
co_scrubber = numbers.clone
oxygen = co = nil
co_found = oxygen_found = false

0.upto(@positions_and_counts.length - 1).each do |position|
  index = position
  puts "\nPosition: #{position}"
  if !oxygen_found
    puts "\nOXYGEN\n"
    count_em_up(oxygen_generator)
    pp oxygen_generator
    print "oxygen_generator: #{oxygen_generator.length}..."
    if (@positions_and_counts[position][1] && @positions_and_counts[position][0]) && (@positions_and_counts[position][0] > @positions_and_counts[position][1])
      # keep numbers with 0 in that position
      print "keep 0..."
      oxygen_generator.reject!{|char_array| char_array[position] == 1}
    else
      # keep numbers with 1 in that position
      print "keep 1..."
      oxygen_generator.reject!{|char_array| char_array[position] == 0}
    end
    print "#{oxygen_generator.length}\n"
    puts ''
    if oxygen_generator.length == 1
      oxygen_found = true
      pp "Found! #{oxygen_generator.first.join}"
      oxygen = oxygen_generator.first.join.to_i(2)
    end
  end
  
  if !co_found
    puts "\nCO\n"
    count_em_up(co_scrubber)
    pp co_scrubber
    print "co_scrubber: #{co_scrubber.length}..."
    if !@positions_and_counts[position][1] || @positions_and_counts[position][1] < @positions_and_counts[position][0]
      # keep numbers with 1 in that position
      print "keep 1..."
      co_scrubber.reject!{|char_array| char_array[position] == 0}
    else
      # keep numbers with 0 in that position
      print "keep 0..."
      co_scrubber.reject!{|char_array| char_array[position] == 1}
    end
    print "#{co_scrubber.length}\n"
    if co_scrubber.length == 1
      co_found = true
      pp "Found! #{co_scrubber.first.join}"
      co = co_scrubber.first.join.to_i(2)
    end
  end
end

puts ''
pp "  #{co}"
pp "x #{oxygen}"
pp "-----------------"
pp co * oxygen



