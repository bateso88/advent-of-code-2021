data = File.read("input.txt").split.each_slice(2).map do |turn| 
  { turn[0].to_sym => turn[1].to_i }
end

sum = Hash.new(0)
data.each_with_object(sum) { |hash, sum| hash.each { |key, value| sum[key] += value }}

p sum[:forward] * (sum[:down] - sum[:up])
