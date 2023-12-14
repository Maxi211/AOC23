data = File.readlines('input.txt', chomp: true)
# data = File.readlines('test.txt',chomp: true)


def tilt_north(grid)
  grid = grid.map{|l|l.split('')}.transpose.map{|r|r.join}.map do |col|
    mut = ""
    point_count = 0
    col.each_char.with_index do |c,i|
      case c
      when 'O'
        mut += c
      when '.'
        point_count +=1
      when '#'
        mut+= '.'*point_count
        mut += '#'
        point_count = 0
      else
        puts "error"
      end
    end
    mut+= '.'*point_count
    mut
  end
  
  return grid
end

sum = 0

grid = tilt_north data
grid.each do |line|
  line.each_char.with_index do |c,i|
    sum += (line.length-i) if c == 'O'
  end
end

puts sum


# Part 2
def trans(grid)
  grid.map{|l|l.split('')}.transpose.map{|r|r.join}
end

def mirror(grid)
  grid.map{|l|l.reverse}
end

def roll_left(grid)
  grid = grid.map do |col|
    mut = ""
    point_count = 0
    col.each_char.with_index do |c,i|
      case c
      when 'O'
        mut += c
      when '.'
        point_count +=1
      when '#'
        mut+= '.'*point_count
        mut += '#'
        point_count = 0
      else
        puts "error"
      end
    end
    mut+= '.'*point_count
    mut
  end
  grid
end

@cash = {}
grid = data
@stable=false

1000.times do |i|
  if @cash.has_key? grid
    grid = @cash[grid][0]
    @stable = @cash[grid][1] if @stable == false
    next
  end

  gri = trans grid
  gri = roll_left gri
  gri = trans gri

  gri = roll_left gri

  gri = trans gri
  gri = mirror gri
  gri = roll_left gri
  gri = mirror gri
  gri = trans gri

  gri = mirror gri
  gri = roll_left gri
  gri = mirror gri
  
  @cash[grid]= [gri,i]
  grid = gri

end

def get_cash(i)
  a = @stable 
  b = @cash.size 
  ((i-b+1)% (b-a+1)) + a -1 
end

grid= @cash.select{|k,v|v[1]== get_cash(1_000_000_000-1)}.first.first
sum = 0
grid = grid.map{|l|l.split('')}.transpose.map{|r|r.join}
grid.each do |line|
  line.each_char.with_index do |c,i|
    sum += (line.length-i) if c == 'O'
  end
end

puts sum
