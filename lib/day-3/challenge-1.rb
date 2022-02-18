data = File.read("input.txt").split.map(&:chars).map {|arr| arr.map(&:to_i) }

gamma_rate = data.transpose.map { |arr| arr.sum > data.length/2 ? 1 : 0 }
epsilon_rate = gamma_rate.map { |digit| digit == 1 ? 0 : 1 }

p power_consumption = gamma_rate.join.to_i(2) * epsilon_rate.join.to_i(2)
