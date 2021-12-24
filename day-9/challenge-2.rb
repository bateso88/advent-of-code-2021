class Challenge

  attr_reader :height_map, :low_points, :height, :width, :adjacent_points, :valid_neighbours

  def initialize
    @height_map = File.read("input.txt").split.map { |row| row.chars.map(&:to_i) }
    @height = height_map.length
    @width = height_map[0].length # assuming all rows are equal length
    @low_points = []
    @adjacent_points = []
    @valid_neighbours = []
  end

  def result 
    calculate_low_points
    @result ||= basin_sizes[-1] * basin_sizes[-2] * basin_sizes[-3]
  end

  private

  def calculate_low_points
    height_map.each.with_index do |row, y| 
      row.each.with_index do |point, x| 
        @adjacent_points = []
        add_points(x, y)
        if adjacent_points.all? { |adjacent_point| adjacent_point > point }
          low_points << [y,x] 
        end
      end 
    end 
  end

  def basin_sizes
    low_points.map do |low_point|
      basin = [low_point]
      starting_length = basin.length
      updated_length = 0

      until starting_length == updated_length do 
        starting_length = basin.length
        basin = add_valid_neighbours(basin)
        updated_length = basin.length
      end

      basin.length
    end.sort
  end

  def add_valid_neighbours(basin)
    @valid_neighbours = []
    basin.each do |y, x|
      add_coords(x,y)
    end
    basin += valid_neighbours
    basin.uniq 
  end

  def add_points(x, y)
    adjacent_points << height_map[y-1][x] if y > 0 
    adjacent_points << height_map[y][x-1] if x > 0
    adjacent_points << height_map[y][x+1] if x < width - 1
    adjacent_points << height_map[y+1][x] if y < height - 1
  end

  def add_coords(x,y)
    valid_neighbours << [y-1,x] if y > 0 && height_map[y-1][x] != 9
    valid_neighbours << [y,x-1] if x > 0 && height_map[y][x-1] != 9
    valid_neighbours << [y,x+1] if x < width - 1 && height_map[y][x+1] != 9
    valid_neighbours << [y+1,x] if y < height - 1 && height_map[y+1][x] != 9
  end
end
