INPUT = 'input.txt'
DEBUG = false
DAYS = 256

def debug_print(stringish)
  puts stringish if DEBUG
end

@fish_generations = Hash.new
file_lines = File.readlines(INPUT)
@days_until_new_fish_wtf = file_lines.first.split(',').collect(&:to_i)

@days_until_new_fish_wtf.each do |fish|
  @fish_generations[fish] ||= 0
  @fish_generations[fish] += 1
end

(1..DAYS).each do |day|
  @next_generation = Hash.new
  (0..8).each do |fish_reproduction_time|
    debug_print fish_reproduction_time
    if fish_reproduction_time == 0
      @next_generation[6] = @fish_generations[fish_reproduction_time] || 0
      @next_generation[8] = @fish_generations[fish_reproduction_time] || 0 
    else
      @next_generation[fish_reproduction_time - 1] ||= 0
      @next_generation[fish_reproduction_time - 1] += @fish_generations[fish_reproduction_time] || 0
    end
  end
  debug_print @next_generation
  @fish_generations = @next_generation
end

puts @fish_generations.values.sum
