data = File.read("input.txt").split("\n").map { |move| move.split }

x = 0; y = 0

data.each do |move| 
  case move[0]
    when "down"
      y += move[1].to_i
    when "up"
      y -= move[1].to_i
    else
      x += move[1].to_i
  end
end

p x 
p y
p x*y
