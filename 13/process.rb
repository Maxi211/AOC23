data = File.readlines('input.txt', chomp: true)
# data = File.readlines('test.txt',chomp: true)

def points(frac)
  frac.each.with_index do |line, index|
    next if index ==0
    if frac[index-1] == line
      len = [index,frac.size-index].min
      return index*100 if frac[(index-len)..(index-1)] == frac[index..(index+len-1)].reverse
    end
  end
  frac =  frac.map{|l|l.split('')}.transpose.map{|r|r.join}
  
  frac.each.with_index do |line, index|
    next if index ==0
    if frac[index-1] == line
      len = [index,frac.size-index].min
      return index if frac[(index-len)..(index-1)] == frac[index..(index+len-1)].reverse
    end
  end
end

sum = 0
frac = []

data.each do |line|
  if line.empty?
    sum += points(frac)
    frac = []
    next
  end
  frac.push line
end

sum += points(frac)
puts sum



# Part 2

def points_b(frac)

  hori = frac.map{|line| line.map.with_index{|char,i| [i,char]}}

  hori.each.with_index do |line, index|
    next if index ==0
    if (hori[index-1].difference line).size <= 1
      len = [index,hori.size-index].min
      hori_1 = hori[(index-len)..(index-1)].flat_map.with_index{|line,index| line.map{|e| [e, index].flatten(1)}}
      hori_2 = hori[index..(index+len-1)].reverse.flat_map.with_index{|line,index| line.map{|e| [e, index].flatten(1)}}
      return index *100 if (hori_1.difference hori_2).size <= 1 && ((hori[index-1] - line).size ==1 ||(hori_1.difference hori_2).size == 1)
    end
  end

  verti =  frac.transpose.map{|line| line.map.with_index{|char,i| [i,char]}}
  
  verti.each.with_index do |line, index|
    next if index ==0
    if (verti[index-1].difference line).size <= 1
      len = [index,verti.size-index].min
      verti_1 = verti[(index-len)..(index-1)].flat_map.with_index{|line,index| line.map{|e| [e, index].flatten(1)}}
      verti_2 = verti[index..(index+len-1)].reverse.flat_map.with_index{|line,index| line.map{|e| [e,index].flatten(1)}}
      return index if (verti_1.difference verti_2).size <= 1 && ((verti[index-1] - line).size == 1 ||(verti_1.difference verti_2).size == 1)
    end
  end
end

sum = 0
frac = []

data.each do |line|
  if line.empty?
    sum += points_b(frac)
    frac = []
    next
  end
  frac.push line.split('')
end
sum += points_b(frac)

puts sum

