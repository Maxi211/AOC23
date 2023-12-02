data = File.readlines('input.txt', chomp: true)
color_max = {'red' => 12, 'green' => 13, 'blue' => 14}
# color_max = {'red' => 12, 'green' => 13, 'blue' => 14}
# all_ids = *(1..100)
# collection = []
sum = 0

data.each do |line|
  # id = line.split(':').first.gsub(/[^\d]/, '')
  color = {}
  color['red'] = [0]
  color['green'] = [0]
  color['blue'] = [0]
  games = line.split(':').last
  games.split(';').each do |game|
    game.split(',').each do |amount_color|
      c = amount_color.split(" ")
      # collection.push(id.to_i) if color_max[c[1]]<c[0].to_i
      color[c[1]].push(c[0].to_i)
    end
  end
  max = color.map do |k, v|
    v.max
  end
  pow = max[0]*max[1]*max[2]
  sum += pow
end

# puts (all_ids - collection.uniq).sum
puts sum