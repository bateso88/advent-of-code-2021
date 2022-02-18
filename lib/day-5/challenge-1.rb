lines = File.read("input.txt")
            .split("\n")
            .map { |line| line.split(" -> ").map { |coords| coords.split(",").map(&:to_i) }}

vertical_lines = lines.select { |line| line[0][0] == line[1][0] }
horizontal_lines = lines.select { |line| line[0][1] == line[1][1] }

all_coords = []

vertical_lines.each do |line|
  x = line[0][0]
  y = [line[0][1], line[1][1]].sort
  (y[0]..y[1]).to_a.each { |y| all_coords << "#{[x,y]}" }
end

horizontal_lines.each do |line|
  x = [line[0][0], line[1][0]].sort
  y = line[0][1]
  (x[0]..x[1]).to_a.each { |x| all_coords << "#{[x,y]}" }
end

sums = Hash.new(0)
all_coords.each { |v| sums[v] += 1 }

p result = sums.select { |k,v| v>1 }.length 
