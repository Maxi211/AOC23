
data = File.readlines('input.txt', chomp: true)
games = {}
# values = ['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2'].reverse # Comment in for Part 1
values = ['A', 'K', 'Q', 'T', '9', '8', '7', '6', '5', '4', '3', '2', 'J'].reverse # Comment out for Part 1
ratings = [[5],[4,1], [3,2],[3,1,1], [2,2,1], [2,1,1,1], [1,1,1,1,1]].reverse

data.each do |line|
  line = line.split(' ')
  games[line[0]] = line[1]
end

games = games.sort_by do |k, v| 
  tally =  k.split("").tally
  joker_count = 0 # Comment out for Part 1
  joker_count = tally.delete("J") if tally["J"] && tally["J"] < 5 # Comment out for Part 1
  rating = tally.values.sort.reverse
  rating[0] += joker_count # Comment out for Part 1
  [ratings.index(rating), values.index(k[0]), values.index(k[1]), values.index(k[2]), values.index(k[3]), values.index(k[4])]
end
sum = 0
games.each.with_index do | game,index|
  sum += game[1].to_i * (index+1)
end
puts sum