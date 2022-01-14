class Challenge 

  attr_reader :coords

  def initialize
    @coords = File.read("input.txt").split.map { |line| line.split(",").map(&:to_i) }
  end

  def result
    do_all_folds
    x_max = coords.transpose[0].max + 1 
    y_max = coords.transpose[1].max + 1
    grid = Array.new(y_max)
    y_max.times do |row_index|
      grid[row_index] = Array.new(x_max)
      x_max.times do |column_index|
        coords.include?([column_index, row_index]) ? grid[row_index][column_index] = :O0 : grid[row_index][column_index] = '.'
      end
    end
    grid
  end

  private

  def do_all_folds # as per instructions
    fold("x", 655)
    fold("y", 447)
    fold("x", 327)
    fold("y", 223)
    fold("x", 163)
    fold("y", 111)
    fold("x", 81)
    fold("y", 55)
    fold("x", 40)
    fold("y", 27)
    fold("y", 13)
    fold("y", 6)
  end

  def fold(axis, value)
    fold_x_axis(value) if axis == "x"
    fold_y_axis(value) if axis == "y"
  end

  def fold_x_axis(value)
    @coords.map! { |x,y| x > value ? [(2 * value) - x, y] : [x, y] }.uniq!
  end

  def fold_y_axis(value)
    @coords.map! { |x,y| y > value ? [x, (2 * value) - y] : [x, y] }.uniq!
  end
end


