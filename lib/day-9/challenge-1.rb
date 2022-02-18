height_map = File.read("input.txt").split.map { |row| row.chars.map(&:to_i) }

low_points = []
risk_level = 0

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
      low_points << { height: point, adj: adjacent_heights } 
    end
  end 
end 

low_points.each { |point| risk_level += point[:height] + 1 }

p risk_level
