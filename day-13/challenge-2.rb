class Challenge 

  attr_reader :coords

  def initialize
    @coords = File.read("input.txt").split.map { |line| line.split(",").map(&:to_i) }
  end

  def result
    all_folds

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

  def x_max
    coords.transpose[0].max + 1
  end

  def y_max
    coords.transpose[1].max + 1
  end

  def all_folds # as per instructions
    fold_x(655)
    fold_y(447)
    fold_x(327)
    fold_y(223)
    fold_x(163)
    fold_y(111)
    fold_x(81)
    fold_y(55)
    fold_x(40)
    fold_y(27)
    fold_y(13)
    fold_y(6)
  end

  def fold_x(value)
    @coords.map! { |x,y| x > value ? [(2 * value) - x, y] : [x, y] }.uniq!
  end

  def fold_y(value)
    @coords.map! { |x,y| y > value ? [x, (2 * value) - y] : [x, y] }.uniq!
  end
end
