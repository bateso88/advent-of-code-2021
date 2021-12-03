data = File.read("input.txt").split.map(&:to_i)

puts data.select.with_index {|depth, i| depth > data[i-1] }.count
