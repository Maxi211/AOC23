
data = File.readlines('input.txt', chomp: true)

# k,v = time,dist
races = data[0].split(" ").zip(data[1].split(" ")).to_h
puts races.inspect
beat = Array.new(4,0)
start = 0
races.each do |k,v|
  k.to_i.times do |i|
    beat[start]+=1 if ((k.to_i - i) * i) > v.to_i
  end
  start += 1
end
puts beat.inspect
product = 1
beat.each do |i|
  product *= i
end

puts product



# 2
beats = 0
time = 59796575
dis = 597123410321328
time.times do |i|
  beats += 1 if ((time - i) * i) > dis
end

puts beats