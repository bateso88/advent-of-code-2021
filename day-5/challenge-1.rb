lines = File.read("input.txt")
            .split("\n")
            .map { |line| line.split(" -> ").map { |coords| coords.split(",").map(&:to_i) }}
            # .select! { |line| x1(line) == x2(line) || y1(line) == y2(line) }

vertical_lines = lines.select { |line| line[0][0] == line[1][0] }
horizontal_lines = lines.select { |line| line[0][1] == line[1][1] }

all_touched_coords = []

vertical_lines.each do |line|
  x_coord = line[0][0]
  y = [line[0][1], line[1][1]].sort
  (y[0]..y[1]).to_a.each { |y_coord| all_touched_coords << [x_coord, y_coord] }
end

horizontal_lines.each do |line|
  x = [line[0][0], line[1][0]].sort
  y_coord = line[0][1]
  (x[0]..x[1]).to_a.each { |x_coord| all_touched_coords << [x_coord, y_coord] }
end

all_touched_coords.map! { |coords| "#{coords}" }

p all_touched_coords.length

sums = Hash.new(0)

# iterate over the array, counting duplicate entries
all_touched_coords.each do |v|
  sums[v] += 1
end

p sums.length

p sums.select { |k,v| v>1 }.length 


