data = File.read("input.txt").split("\n").map { |move| move.split }

y = 0

x = data.select {|move| move[0] == "forward"}.map{|move| move[1].to_i }.sum
up = data.select {|move| move[0] == "up"}.map{|move| move[1].to_i }.sum
down = data.select {|move| move[0] == "down"}.map{|move| move[1].to_i }.sum

p x
p down - up 
p x*(down - up)
