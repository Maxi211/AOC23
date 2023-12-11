# General
data = File.readlines('input.txt', chomp: true)
# data = File.readlines('test.txt', chomp: true)
grid = {}
data.each.with_index do |line,index|
  line.each_char.with_index do |c,i|
    grid[[i+1,index+1]]=c
  end
end

# helper
def p(x)
  puts x.inspect
end

def print_grid(grid)
  puts "  0    5    1"
  grid.group_by{|k,v|k[1]}.sort_by{|r|r[0]}.each do |row|
    print "#{row[0]}#{" "*(3-row[0].to_s.length)}"
    row[1].each do |x|
      print x[1]
    end
    puts ""
  end
end

grid
cols = grid.group_by{|k,v|k[0]}
rows = grid.group_by{|k,v|k[1]}
col_count = cols.size
empty_cols_x_value=[]
row_count = rows.size
empty_rows_y_value=[]

rows.each do |row|
  next if row[1].any?{|cell| cell[1] == '#'}
  empty_rows_y_value << row[0]
end

empty_rows_y_value.each do |y|
  col_count.times do |x|
    grid[[x+1,y]]='x'
  end
end 

cols.each do |col|
  next if col[1].any?{|cell| cell[1] == '#'}
  empty_cols_x_value << col[0]
end

empty_cols_x_value.each do |x|
  row_count.times do |y|
    grid[[x,y+1]]='x'
  end
end

galaxies = grid.select{|k,v|v == '#'}.map{|k,v|k}
sum = 0
while galaxies.size > 1
  cx, cy = galaxies.pop
  galaxies.each do |x,y|
  x_count = 0
  if cx<x
    (x-cx).times do |i|
      x_count += 1 if grid[[cx+i,cy]]== 'x'
    end
  else
    (cx-x).times do |i|
      x_count += 1 if grid[[x+i,cy]] == 'x'
    end
  end
  if cy<y
    (y-cy).times do |i|
      x_count +=1 if  grid[[cx,cy+i]] == 'x'
    end
  else
    (cy-y).times do |i|
      x_count += 1 if grid[[cx,y+i]] == 'x'
    end
  end
  distance = (cx-x).abs + (cy-y).abs - x_count + (x_count*1_000_000)
  sum += distance
  end
end
puts sum
