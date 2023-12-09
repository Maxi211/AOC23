# general
data = File.readlines('input.txt', chomp: true)
lines = data.map{|l| l.split(' ').map(&:to_i)}

# Part 1

sum = 0
lines.each do |line|
  steps = []
  while line.uniq !=[0]
    steps << line[-1]
    line =  line.map.with_index do |num, index|
      next if index == 0
      num - line[index - 1]
    end.compact
  end
  sum += steps.sum
end

puts sum


# Part 2

sum = 0
lines.each do |line|
  steps = []
  while line.uniq !=[0]
    steps << line[0]
    line =  line.map.with_index do |num, index|
      next if index == 0
      num - line[index - 1]
    end.compact
  end
  partsum = 0
  steps.each_with_index do |step, index|
     if index%2 == 0
      partsum += step
     else
      partsum -= step
     end
  end
  sum += partsum
end

puts sum