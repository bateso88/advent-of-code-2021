data = File.read("input.txt").split.each_slice(2).map { |move| { move[0].to_sym => move[1].to_i }}

h = Hash.new(0)
sum = data.each_with_object(h) { |hash, h| hash.each { |key, value| h[key] += value }}

p sum[:forward] * (sum[:down] - sum[:up])
