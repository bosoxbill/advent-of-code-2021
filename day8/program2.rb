# acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab |
# cdfeb fcadb cdfeb cdbaf
#
# two-character signal is ab. ab == 1 a -> c|f, b -> c|f
# three-character is dab. dab == 7. d -> a
# four-character is eafb. eafb == 4. e -> b|d, f -> b|d
# seven-character is acedgfb. acedgfb == 7
# 2, 3, and 5 are five segments. fbcad is one of these. Because it has both a and b, which map to c and f, it must be 3. That gives us digit 2 and 4
# cdfeb includes segment a, b, d. 2 doesn't have those, 5 does. Therefore digits 1 and 3 are 5.

# how to identify each number:
# zero has six segments, contains one's segments, and is missing one of four's segments
# one has two segments
# two has five segments, has the segment six is missing, and does not have one's segments
# three has five segments and contains one's segments
# four has four segments
# five has five segments and does not have the segment six is missing
# six has six segments and is missing one of one's segments
# seven has three segments
# eight has seven segments
# nine has six segments and contains all of four's segments

def main
  lines = File.readlines('./input.txt').map { |line| line.chomp.split(" | ").map(&:split) }
  decoded_outputs = lines.map do |signals, outputs|
    one = signals.detect { |signal| signal.length == 2 }.chars.sort.join
    three = signals.detect { |signal| signal.length == 5 && one.chars.all? { |c| signal.chars.include?(c) } }.chars.sort.join
    six = signals.detect { |signal| signal.length == 6 && one.chars.any? { |c| !signal.chars.include?(c) } }.chars.sort.join
    two = signals.detect { |signal| signal.length == 5 && signal.chars.include?(("abcdefg".chars - six.chars).first) && one.chars.any? { |c| !signal.chars.include?(c) } }.chars.sort.join
    five = signals.detect { |signal| signal.length == 5 && !signal.chars.include?(("abcdefg".chars - six.chars).first) }.chars.sort.join
    four = signals.detect { |signal| signal.length == 4 }.chars.sort.join
    nine = signals.detect { |signal| signal.length == 6 && four.chars.all? { |c| signal.chars.include?(c) } }.chars.sort.join
    zero = signals.detect { |signal| signal.length == 6 && one.chars.all? { |c| signal.chars.include?(c) } && four.chars.any? { |c| !signal.chars.include?(c) } }.chars.sort.join
    seven = signals.detect { |signal| signal.length == 3 }.chars.sort.join
    eight = signals.detect { |signal| signal.length == 7 }.chars.sort.join
    decoder = {}
    decoder[zero] = 0
    decoder[one] = 1
    decoder[two] = 2
    decoder[three] = 3
    decoder[four] = 4
    decoder[five] = 5
    decoder[six] = 6
    decoder[seven] = 7
    decoder[eight] = 8
    decoder[nine] = 9

    if decoder.size != 10
      puts "failed to decode something!"
      puts "decoder: #{decoder.inspect}"
      puts "#{signals} | #{outputs}"
    end
    outputs.map { |output| decoder[output.chars.sort.join] }.join.to_i
  end
  puts decoded_outputs.sum
end

main if __FILE__ == $PROGRAM_NAME
