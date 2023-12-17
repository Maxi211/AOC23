data = File.readlines('input.txt', chomp: true)
# data = File.readlines('test.txt',chomp: true)

def one_beam(start_coordinates, direction)

  current_pos = [start_coordinates[0]+direction[0],start_coordinates[1]+direction[1]]

  return  if current_pos.min < 0 || current_pos[0] > @x_max || current_pos[1] > @y_max || @lighted_points[current_pos].include?(direction)
  
  up = direction == [0,-1]
  down = direction == [0,1]
  right = direction == [1,0]
  left = direction == [-1,0]

  while true
    @lighted_points[current_pos] = [@lighted_points[current_pos] + [direction]].flatten(1)
    
    command = @grid[current_pos]
    case command
    when '.'
    when '|'
      if right || left
        one_beam(current_pos,[0,-1])
        one_beam(current_pos,[0,1])
        return 
      end
    when '-'
      if up || down
        one_beam(current_pos,[-1,0])
        one_beam(current_pos,[1,0])
        return 
      end
    when '/'
      one_beam(current_pos,[0,1]) if left 
      one_beam(current_pos,[0,-1]) if right
      one_beam(current_pos,[1,0]) if up
      one_beam(current_pos,[-1,0]) if down
      return
    when '\\'
      one_beam(current_pos,[0,1]) if right 
      one_beam(current_pos,[0,-1]) if left
      one_beam(current_pos,[1,0]) if down
      one_beam(current_pos,[-1,0]) if up
      return
    else
      return "ERROR"
    end
    current_pos = [current_pos[0]+direction[0],current_pos[1]+direction[1]]
    return  if current_pos.min < 0 || current_pos[0] > @x_max || current_pos[1] > @y_max || @lighted_points[current_pos].include?(direction)  
  end
end



@grid ={}
@x_max = data.first.size() - 1
@y_max = data.size() - 1

data.each.with_index do |line,index|
  line.each_char.with_index do |char,i|
    @grid[[i,index]] = char
  end
end

@grid.freeze
sizes = []

@lighted_points = Hash.new([])
one_beam([-1,0],[1,0])
puts "First Part: #{@lighted_points.size}"

# from left
[-1].product((0..@y_max).to_a).product([[1,0]]).each do |start|
  @lighted_points = Hash.new([])
  one_beam(*start)
  sizes << @lighted_points.size
end
#from right
[@x_max+1].product((0..@y_max).to_a).product([[-1,0]]).each do |start|
  @lighted_points = Hash.new([])
  one_beam(*start)
  sizes << @lighted_points.size
end
#from top
(0..@x_max).to_a.product([-1]).product([[0,1]]).each do |start|
  @lighted_points = Hash.new([])
  one_beam(*start)
  sizes << @lighted_points.size
end
#from bottom
(0..@x_max).to_a.product([@y_max+1]).product([[0,-1]]).each do |start|
  @lighted_points = Hash.new([])
  one_beam(*start)
  sizes << @lighted_points.size
end

puts "First Part: #{sizes.max}"



# data.each.with_index do |line, index|
#   puts ""
#   line.each_char.with_index do |char, i|
#     if @lighted_points[[i,index]].size > 0
#       print '#'
#     else
#       print char
#     end
#   end
# end