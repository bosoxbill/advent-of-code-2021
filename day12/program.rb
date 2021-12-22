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
end

pp @caves
def small?(cave)
  cave != "end" && cave.downcase == cave
end

@path = Array.new
@paths = Array.new

def enter_cave(cave, current_path)
  puts "entering " + cave
  @path.push cave
  if cave == 'end'
    @paths << @path
    debug_print @path.join(',')
  else
    @caves[cave].each do |next_cave|
      unless small?(next_cave) && @path.include?(next_cave)
        enter_cave(next_cave, @path.clone)
      else
        puts "Can't enter #{next_cave} because small: #{small?(next_cave)} or path had us in there:"
        pp @path
      end
    end
  end
end

enter_cave('start', @path)

puts @paths.count
