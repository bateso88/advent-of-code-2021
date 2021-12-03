data = File.read("input.txt").split.map(&:to_i)

puts data.each_cons(2).select {|x| x[1] > x[0] }.count
