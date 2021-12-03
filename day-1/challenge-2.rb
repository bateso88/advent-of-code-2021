data = File.read("input.txt").split.map(&:to_i)

sum_data = data.each_cons(3).map(&:sum)

puts sum_data.each_cons(2) {|x, y| y > x }.count