# Part 1
data = File.readlines('input.txt', chomp: true)
instructions = "LRRLLRLLRRRLRRLRLRRRLRLLRLRRLRRRLRRRLRRLRRRLRLRRRLRLRRLRLRRRLRRLLRRLLLRRLRLRRRLRLRRRLRRLRRRLRLLRRLRRLRLRRRLRRRLRRLRRLLRLLRRRLRLRRLRRRLRRLRRRLRRRLLLLRRLRLRRRLRRRLLRRLLRRLRRRLRRRLRLRLLRRLRLRLRLRLRRLRLRLRRRLRRLRRLRRLRRRLRLRRRLRLRRLRLLLLRRRLLRRRLRLLRRRLRLLRRRLLRRLRLRLRLRLLLLRRLRRRLRLLRRLRRRLRRRLRLRRLRRLRLLRRRR"
# instructions = "LR"
map = {}

data.each do |line|
  line = line.split('=')
  map[line[0].gsub(/\W/, "")] = line[1].chomp.split(',').map{|x| x.gsub(/\W/,"")}
end

step = 0
ky = 'AAA'
aim = 'ZZZ'
while ky != aim
  instructions.each_char do |c|
    ky = c == 'L' ? map[ky][0] : map[ky][1]
    step += 1
  end
end
puts step

# Part 2

kys = map.keys.select{|x| x[-1] == 'A'}
new_map = {}
map.each do |k,v|
  new_map[k] = k
end

instructions.each_char do |c|
  new_map = new_map.transform_values{|v| c == 'L' ? map[v][0] : map[v][1]}
end

hits = []
kys.each do |k|
  step = 0
  test = k
  while hits.length < 10
    test = new_map[test]
    step += 1
    hits << step if test[-1] == 'Z'
    break if test[-1] == 'Z'
  end
end

solution = instructions.length
hits.each do |hit|
  solution *= hit #only works if all the hits are prime :) which they are !
end
puts solution
