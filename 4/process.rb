data = File.readlines('input.txt', chomp: true)
# card = [hits, number_of_card_itself]
cards = {}
sum = 0 

data.each do |line|
  hits = 0
  card_number = line.split(':')[0].split(" ")[1].to_i
  winnning_numbers = line.split('|')[0].split(':')[1].split(" ")
  tries = line.split('|')[1].split(" ")
  tries.each do |try|
    if winnning_numbers.include?(try)
      hits += 1
    end
  end

  # points = 1
  # (hits-1).times do
  #   points = points*2
  # end

  cards[card_number] = [hits, 1]
end

cards.each do |card_number, points|
  points.first.times do |i|
    break if card_number+i+1 > data.size
    points.last.times do
      cards[card_number+i+1] = [cards[card_number+i+1].first, cards[card_number+i+1].last+1]
    end
  end
end

sum = cards.sum do |card_number, points|
  points.last
end

puts sum
