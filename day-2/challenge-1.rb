data = File.read("input.txt").split("\n").map { |move| move.split }

x = data.select { |move| move[0] == "forward" }.map{|move| move[1].to_i }.sum
y = data.select { |move| move[0] != "forward" }.map { |move| move[0] == "up" ? -move[1].to_i : move[1].to_i }.sum

p x, y, x*y
