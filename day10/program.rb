INPUT = 'input.txt'
DEBUG = false

#  ): 3 points.
#  ]: 57 points.
#  }: 1197 points.
#  >: 25137 points.
CODEX = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>'
}

def debug_print(stringish)
  puts stringish if DEBUG
end

@lines = Array.new
@chonks = Array.new
file_lines = File.readlines(INPUT)
file_lines.each do |line|
  @lines << line.chomp.chars
end

@stack = Array.new
@errors = Hash.new{|h,k| h[k] = Hash.new }
@lines.each_with_index do |line, l_index|
  error = false
  line.each_with_index do |char, c_index|
    next if error
    debug_print "checking line #{c_index} - #{char}"
    if CODEX.values.include? char
      if CODEX[@stack.last] == char
        @stack.pop
      else
        debug_print "error line #{l_index}: expected #{@stack.last}, got #{char}"
        @errors[l_index][:stack_top] = @stack.last
        @errors[l_index][:char] = char
        error = true
      end
    elsif CODEX.keys.include? char
      debug_print "   ...opening an obj!"
      @stack.push char
    end
  end
end

pp @errors
POINTS = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137
}

score = 0
@errors.each do |line, error_hash|
  score += POINTS[error_hash[:char]]
end

pp score
