class Octopus 

  attr_reader :y, :x, :neighbours, :energy

  def initialize(y, x, energy)
    @y = y
    @x = x
    @energy = energy.to_i
    @need_to_update_neighbours = false
    @neighbours = []
  end

  def find(octopuses)
    #above
    neighbours << [y-1,x-1] if x > 0 && y > 0
    neighbours << [y-1,x] if y > 0
    neighbours << [y-1,x+1] if y > 0 && x < 9
    #beside
    neighbours << [y,x-1] if x > 0
    neighbours << [y,x+1] if x < 9
    #below
    neighbours << [y+1,x-1] if x > 0 && y < 9
    neighbours << [y+1,x] if y < 9
    neighbours << [y+1,x+1] if y < 9 && x < 9
  end

  def increment_energy 
    @energy += 1
  end

  # def updated?
  #   energy == 0
  # end

  # def need_to_update_neighbours?
  #   energy > 9
  # end

  def update_neighbours
    return if energy <= 9
    #### NEXT STEP IN HERE
  end

end


class Game

  attr_reader :octopuses
  
  def initialize
    @octopuses = File.read("input.txt").split.map.with_index { |row, y| row.chars.map.with_index { |energy, x| Octopus.new(y, x, energy) }}
    find_neighbours
  end
  
  def step
    octopuses.each { |row| row.each { |octopus| octopus.increment_energy }}
    octopuses.each { |row| row.each { |octopus| octopus.update_neighbours }}
    show
  end
  
  def show 
    octopuses.each { |row| p row.map { |octopus| octopus.energy }}
    return
  end
 
  private

  def find_neighbours
    octopuses.each { |row| row.each { |octopus| octopus.find(octopuses) }}
  end

end
