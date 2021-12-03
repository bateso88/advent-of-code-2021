data = File.read("input.txt").split.each_slice(2).map do |turn| 
  { direction: turn[0], amount: turn[1].to_i }
end

x = 0; y = 0; aim = 0

data.each do |turn| 
  case turn[:direction]
  when "up"
    aim -= turn[:amount]
  when "down"
    aim += turn[:amount]
  else
    x += turn[:amount]
    y += (turn[:amount] * aim)
  end
end

p x * y