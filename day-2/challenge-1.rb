data = File.read("input.txt").split("\n").map { |move| move.split }

y = 0

x = data.select {|move| move[0] == "forward"}.map{|move| move[1].to_i }.sum
up = data.select {|move| move[0] == "up"}.map{|move| move[1].to_i }.sum
down = data.select {|move| move[0] == "down"}.map{|move| move[1].to_i }.sum

data.each do |move| 
  case move[0]
    when "down"
      y += move[1].to_i
    when "up"
      y -= move[1].to_i
  end
end

p x
p y
p down - up 
p x*y
