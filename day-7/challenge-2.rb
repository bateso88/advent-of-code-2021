crabs = File.read("input.txt").split(",").map(&:to_i)

fuel_costs = (crabs.min..crabs.max).to_a.map do |pos| # This is overkill!!
  fuel = 0 
  crabs.each { |x| fuel += (1..([x, pos].max - [x,pos].min)).sum } 
  fuel
end

p fuel_costs.min # position is 358