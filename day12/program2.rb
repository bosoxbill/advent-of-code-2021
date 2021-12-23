INPUT = ENV['INPUT'] ? ENV['INPUT'] : 'input.txt'
DEBUG = ENV['DEBUG'] ? true : false

def debug_print(stringish)
  pp stringish if DEBUG
end

@caves = Hash.new{|h, k| h[k] = Array.new}

file_lines = File.readlines(INPUT)
file_lines.each do |line|
  from, to = line.chomp.split('-')
  @caves[from] << to
  @caves[to] << from
end

debug_print @caves
def small?(cave)
  cave.downcase == cave
end

def has_double_small?(path)
  path.any?{|cave| small?(cave) && path.count(cave) == 2}
end

def can_enter?(cave, path)
  debug_print "Can I enter #{cave} on path #{path.join(',')}"
  if cave == 'start'
    debug_print "...false"
    return false
  end
  cave_on_path = path.include?(cave)
  double_already = has_double_small?(path)
  retval = !small?(cave) || !cave_on_path || !double_already
  debug_print "...#{retval} (cave on path: #{cave_on_path}, double_already: #{double_already}"
  return retval
end

@path = Array.new
@paths = Array.new

def enter_cave(cave, current_path)
  debug_print "entering #{cave} on path #{current_path.join(',')}" 
  current_path.push cave
  if cave == 'end'
    @paths << current_path
    debug_print @path.join(',')
  else
    @caves[cave].each do |next_cave|
      debug_print "looking at #{next_cave}"
      if can_enter?(next_cave, current_path) 
        enter_cave(next_cave, current_path.clone)
      end
    end
  end
end

enter_cave('start', @path)

puts @paths.count
