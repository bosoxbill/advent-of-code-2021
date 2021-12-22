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

@path = Array.new
@paths = Array.new

def enter_cave(cave, current_path)
  puts "entering " + cave
  current_path.push cave
  if cave == 'end'
    @paths << current_path
    debug_print @path.join(',')
  else
    @caves[cave].each do |next_cave|
      debug_print "looking at #{next_cave}"
      unless small?(next_cave) && current_path.include?(next_cave)
        enter_cave(next_cave, current_path.clone)
      end
    end
  end
end

enter_cave('start', @path)

puts @paths.count
