data = File.read("input.txt").split.map(&:to_i)

sum_data = data.each_cons(3).map(&:sum)

puts sum_data.select.with_index {|depth, i| depth > sum_data[i-1] }.count