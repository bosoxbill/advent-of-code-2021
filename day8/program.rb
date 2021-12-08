INPUT = 'input.txt'
DEBUG = false

def debug_print(stringish)
  puts stringish if DEBUG
end

@outputs = Array.new
File.readlines(INPUT).each do |line|
  input_codes, output = line.split('|')
  @outputs += output.chomp.split(' ')
end
pp @outputs
count = 0
@outputs.each do |output_code|
  puts "#{output_code}: #{output_code.chars.count}" 
  if [1, 2, 3, 4, 7].include? output_code.chars.count
    count += 1
  end
end

pp count
