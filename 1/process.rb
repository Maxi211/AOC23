lines = File.readlines('input.txt', chomp: true)

hash = {'one' => 'on1e', 'two' => 'tw2o', 'three' => 'thr3ee', 'four' => 'fo4ur', 'five' => 'fi5ve', 'six' => 'si6x', 'seven' => 'sev7en', 'eight' => 'eig8ht', 'nine' => 'ni9ne'}

sum = lines.map do |line|
  digits = line.gsub(/one|two|three|four|five|six|seven|eight|nine/, hash)
              .gsub(/one|two|three|four|five|six|seven|eight|nine/, hash)
              .gsub(/[^\d]/, '')

  [digits[0], digits[-1]].join.to_i
end

# sum.each_with_index do |s, i|
#   puts "#{lines[i]}: #{ sum[i] }"
# end

puts sum.sum

