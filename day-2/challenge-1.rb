data = File.read("input.txt").split.each_slice(2).to_a

x = data.select { |move| move[0] == "forward" }.map{|move| move[1].to_i }.sum
y = data.select { |move| move[0] != "forward" }.map { |move| move[0] == "up" ? -move[1].to_i : move[1].to_i }.sum

p x, y, x*y
