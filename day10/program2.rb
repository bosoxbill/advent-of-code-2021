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

POINTS = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}

def debug_print(stringish)
  pp stringish if DEBUG
end

@lines = Array.new
@chonks = Array.new
file_lines = File.readlines(INPUT)
file_lines.each do |line|
  @lines << line.chomp.chars
end

@stack = nil
@errors = Hash.new{|h,k| h[k] = Hash.new }
@autocompletes = Hash.new
@lines.each_with_index do |line, l_index|
  @stack = Array.new
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
  if !error
    #finish the line
    @stack.each do |unloved_opener|
      @autocompletes[l_index] ||= Hash.new
      @autocompletes[l_index][:chars] ||= Array.new
      @autocompletes[l_index][:chars] << CODEX[unloved_opener]
    end
  end
end

@scores = Array.new
@autocompletes.each do |_line, error_hash|
  score = 0
  error_hash[:chars].reverse.each do |error_char|
    score = score * 5
    score += POINTS[error_char]
  end
  @scores << score
end

pp @scores.sort[@scores.length / 2]
