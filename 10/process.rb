# general
data = File.readlines('input.txt', chomp: true)
# data = File.readlines('test.txt', chomp: true)
grid = {}
data.each.with_index do |line,index|
  line.each_char.with_index do |c,i|
    grid[[i+1,index+1]]=c unless c == '.'
  end
end

def hori?(a,b)
  a[1]==b[1]
end

# Part 1

# step = 1
# starting_coordinate = grid.key 'S'
# previous = starting_coordinate

# # return putts starting_coordinate
# current = [76,96]
# # current = [2,3]

# while true
#   step += 1
#   # putts previous
#   # putts current
#   direction = grid[current]
  
#   case direction
#   when '|'
#     y = current[1] > previous[1] ? 1 : -1
#     previous = current
#     current = [current[0], current[1]+y]
#   when '-'
#     x = current[0] > previous[0] ? 1 : -1
#     previous = current
#     current = [current[0]+x, current[1]]
#   when 'L'
#     if hori? current,previous
#     previous = current
#     current = [current[0], current[1]-1]
#   else
#     previous = current
#     current = [current[0]+1, current[1]]
#   end
#   when 'J'
#     if hori? current,previous
#       previous = current
#       current = [current[0], current[1]-1]
#     else
#       previous = current
#       current = [current[0]-1, current[1]]
#     end
#   when '7'
#     if hori? current,previous
#       previous = current
#       current = [current[0], current[1]+1]
#     else
#       previous = current
#       current = [current[0]-1, current[1]]
#     end
#   when 'F'
#     if hori? current,previous
#       previous = current
#       current = [current[0], current[1]+1]
#     else
#       previous = current
#       current = [current[0]+1, current[1]]
#     end
#   when 'S'
#     break
#   else
#     puts "error" + direction.to_s
#     break
#   end
# end
# puts (step-1) /2


# Part 2
waypoints = []

starting_coordinate = grid.key 'S'
previous = starting_coordinate
waypoints<<previous
# return puts starting_coordinate.inspect
current = [76,96]
# current = [5,2]

while true
  direction = grid[current]
  waypoints << current
  case direction
  when '|'
    y = current[1] > previous[1] ? 1 : -1
    previous = current
    current = [current[0], current[1]+y]
  when '-'
    x = current[0] > previous[0] ? 1 : -1
    previous = current
    current = [current[0]+x, current[1]]
  when 'L'
    if hori? current,previous
    previous = current
    current = [current[0], current[1]-1]
  else
    previous = current
    current = [current[0]+1, current[1]]
  end
  when 'J'
    if hori? current,previous
      previous = current
      current = [current[0], current[1]-1]
    else
      previous = current
      current = [current[0]-1, current[1]]
    end
  when '7'
    if hori? current,previous
      previous = current
      current = [current[0], current[1]+1]
    else
      previous = current
      current = [current[0]-1, current[1]]
    end
  when 'F'
    if hori? current,previous
      previous = current
      current = [current[0], current[1]+1]
    else
      previous = current
      current = [current[0]+1, current[1]]
    end
  when 'S'
    break
  else
    puts "error" + direction.to_s
    break
  end
end
area = 0
waypoints=waypoints.group_by{|p| p[1]}
waypoints.each do |key,values|
  values = values.uniq.sort{|a,b|a[0]<=>b[0]}
  bound = values[-1]
  current = values[0]
  number_of_pipes = ['|','7','F'].include?(grid.fetch(current,'')) ? 1 : 0 # J L would require S as well
  while true
    current = [current[0]+1,current[1]]
    break if current == bound
    number_of_pipes += 1 if ['|','7','F'].include?(grid.fetch(current,'')) && values.include?(current)
    next if values.include?(current)
    area += 1 if number_of_pipes%2 == 1
  end
end

puts area