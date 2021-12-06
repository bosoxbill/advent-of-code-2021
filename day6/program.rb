INPUT = 'test1.txt'
DEBUG = false
DAYS = 80

def debug_print(stringish)
  puts stringish if DEBUG
end

@days_until_new_fish_wtf = Array.new
@next_days_fish_counts = Array.new

file_lines = File.readlines(INPUT)
@days_until_new_fish_wtf = file_lines.first.split(',').collect(&:to_i)

(1..DAYS).each do |day|
  bonus_fish = Array.new
  @next_days_fish_counts = Array.new
  @days_until_new_fish_wtf.each do |fish|
    if fish == 0
      next_fish = 6
      bonus_fish << 8
    else
      next_fish = fish - 1
    end
    @next_days_fish_counts << next_fish
  end
  @days_until_new_fish_wtf = @next_days_fish_counts + bonus_fish
  debug_print("      day #{day}: #{@days_until_new_fish_wtf.count}")
end

puts @days_until_new_fish_wtf.count
