height_map = File.read("input.txt").split.map { |row| row.chars.map(&:to_i) }

##### Establish low points 

low_points = []

height = height_map.length
width = height_map[0].length # assuming all rows are equal length

height_map.each.with_index do |row, y| 
  row.each.with_index do |point, x| 
    adjacent_heights = []
    adjacent_heights << height_map[y-1][x] if y > 0
    adjacent_heights << height_map[y][x-1] if x > 0
    adjacent_heights << height_map[y][x+1] if x < width - 1
    adjacent_heights << height_map[y+1][x] if y < height - 1
    if adjacent_heights.all? { |adjacent_point| adjacent_point > point }
      low_points << [y,x] 
    end
  end 
end 

##### Simplify height map 

shm = height_map.map { |row| row.map { |point| point == 9 ? 0 : 1 }}

##### Function to calculate and append valid neighbours to current basin values

def add_valid_neighbours(basin, simple_height_map) ##### Defo needs a refactor
  height = simple_height_map.length
  width = simple_height_map[0].length # assuming all rows are equal length
  valid_neighbours = []
  basin.each do |coords|
    y = coords[0]
    x = coords[1]
    valid_neighbours << [y-1,x] if y > 0 && simple_height_map[y-1][x] == 1
    valid_neighbours << [y,x-1] if x > 0 && simple_height_map[y][x-1] == 1
    valid_neighbours << [y,x+1] if x < width - 1 && simple_height_map[y][x+1] == 1
    valid_neighbours << [y+1,x] if y < height - 1 && simple_height_map[y+1][x] == 1
  end
  basin << valid_neighbours
  basin.flatten.each_slice(2).map { |coords| [coords[0], coords[1]] }.uniq 
end

##### Create an array of values for the size of each basin

basin_sizes = low_points.map do |low_point|
  basin = [low_point]
  length_before = basin.length
  length_after = basin.length + 1

  until length_before == length_after do 
    length_before = basin.length
    basin = add_valid_neighbours(basin, shm)
    length_after = basin.length
  end

  basin.length
end.sort!

p basin_sizes[-1] * basin_sizes[-2] * basin_sizes[-3]

##### The whole thing should probs be refactored into a class and should make use of instance variables