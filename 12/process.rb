data = File.readlines('input.txt', chomp: true)
data = File.readlines('test.txt', chomp: true)

# def all_combinations(number)
#   combination = []
#   (0..((2**number)-1)).each do |i|
#     var = i.to_s(2)
#     combination << (('0'*(number-var.length))+ i.to_s(2)).gsub('0','.').gsub('1','#')
#   end
#   combination
# end

# def valid?(chars,numbers)
#   counts = []
#   current_count=0
#   chars.each_char do |c|
#     if c=="#"
#       current_count+=1
#     else
#       counts << current_count 
#       current_count = 0
#     end
#   end
#   counts << current_count
#   counts - [0] == numbers
# end

# valid = 0
# data.each do |line|
#   str, numbers = line.split(" ")
#   numbers = numbers.split(',').map(&:to_i)
#   position_unknown = []
#   str.each_char.with_index do |c, i|
#     position_unknown << i if c=='?'
#   end
#   fillings = all_combinations(position_unknown.size)
#   fillings.each do |fil|
#     position_unknown.each_with_index do |p,i|
#       str[p]=fil[i]
#     end
#     valid += 1 if valid?(str,numbers)
#   end
# end
# puts valid


#part 2
@cache = {}
def count(str,numbers)
  if str.nil? || str.empty?
    return 1 if numbers.empty?
    return 0
  end

  if numbers.empty?
    return 0 if str && str.include?('#')
    return 1
  end

  key = [str,numbers]
  return @cache[key] if @cache[key]

  possiblities = 0

  if ".?".include? str[0]
    possiblities += count(str[1..], numbers)
  end

  if "#?".include? str[0]
    if (numbers[0] <= str.length && !(str[...numbers[0]].include?('.')) && (numbers[0]==str.length || str[numbers[0]]!= '#'))
      possiblities += count(str[(numbers[0]+1)..],numbers[1..])
    end
  end

  @cache[key]=possiblities
  possiblities
end

sum = 0

data.each.with_index do |line,i|
  str, numbers = line.split(" ")
  numbers = numbers.split(',').map(&:to_i)*5
  str = ([str,'?']*4).join+str
  sum +=count(str,numbers)
end

puts sum
