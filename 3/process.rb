
# def neighbors?(line_index, char_index, length, signs_positions)
#   neighbor_positions = []
#   (line_index-1..line_index+1).each do |li|
#     (char_index-(length+1)..char_index).each do |ci|
#       neighbor_positions.push "#{li}_#{ci}"
#     end
#   end
#    neighbor_positions.intersect?(signs_positions)
# end

def neighbor_gears(line_index, char_index, length, signs_positions, number)
  neighbor_positions = []
  (line_index-1..line_index+1).each do |li|
    (char_index-(length+1)..char_index).each do |ci|
      neighbor_positions.push "#{li}_#{ci}"
    end
  end
   neighbor_positions.intersection(signs_positions).each do |position|
     @gear_positions[position].push number
   end
end

data = File.readlines('input.txt', chomp: true)

@gear_positions = {}
# signs_positions = []
# data.each.with_index do |line, index|
#   line.each_char.with_index do |char, i|
#     signs_positions.push "#{index}_#{i}" if !char.match?(/[\d]/) && char != '.'
#   end
# end
data.each.with_index do |line, index|
  line.each_char.with_index do |char, i|
    @gear_positions["#{index}_#{i}"]=[] if char == '*'
  end
end

# sum = 0
# current_number = ''
# data.each.with_index do |line, line_index|
#   line.each_char.with_index do |char, char_index|
#     if char.match?(/[\d]/)
#       current_number += char
#       if char_index == line.length-1
#         sum += current_number.to_i if neighbors?(line_index, char_index+1, current_number.length, signs_positions)
#         current_number = ''
#       end
#     else
#       if char == '.' && current_number.length > 0
#         sum += current_number.to_i if neighbors?(line_index, char_index, current_number.length, signs_positions)
#         current_number = ''
#       else
#         sum += current_number.to_i if current_number.length > 0
#         current_number = ''
#       end
#     end
#   end
# end
current_number = ''
data.each.with_index do |line, line_index|
  line.each_char.with_index do |char, char_index|
    if char.match?(/[\d]/)
      current_number += char
      if char_index == line.length-1
        neighbor_gears(line_index, char_index+1, current_number.length, @gear_positions.keys, current_number.to_i)
        current_number = ''
      end
    else
      if current_number.length > 0
        neighbor_gears(line_index, char_index, current_number.length, @gear_positions.keys, current_number.to_i)
        current_number = ''
      end
    end
  end
end

sum = @gear_positions.sum do |position, numbers|
  if numbers.length > 1
    product = numbers[0]
    numbers[1..-1].each do |number|
      product = product * number
    end
    product
  else
    0
  end
end

puts sum