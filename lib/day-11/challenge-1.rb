class Octopus 

  attr_reader :y, :x, :neighbours, :energy, :has_flashed, :need_to_update_neighbours

  def initialize(y, x, energy)
    @y = y
    @x = x
    @energy = energy.to_i
    @need_to_update_neighbours = false
    @has_flashed = false
    find_neighbours
  end

  def increment_energy
    return if has_flashed
    @energy += 1
    if energy > 9
      @has_flashed = true
      @need_to_update_neighbours = true
      @energy = 0
    end
  end

  def reset_need_to_update_neighbours
    @need_to_update_neighbours = false
  end

  def reset_flash
    @has_flashed = false
  end

  private 

  def find_neighbours
    @neighbours = []
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
end


class Challenge

  attr_reader :octopuses, :flash_count
  
  def initialize
    @octopuses = File.read("input.txt").split.map.with_index { |row, y| row.chars.map.with_index { |energy, x| Octopus.new(y, x, energy) }}
    @coords_to_update = []
    @flash_count = 0
  end

  def result
    100.times { step }
    flash_count
  end
  
  private
  
  def step
    increment_energy(pod)
    update_neighbours
    update_flash_count
    show
  end

  def show 
    octopuses.each { |row| p row.map { |octopus| octopus.energy }}
    p '----------------------------'
    return
  end

  def pod 
    octopuses.flatten
  end

  def coords_to_update
    @coords_to_update = @coords_to_update.flatten.each_slice(2).map {|coords| [coords[0], coords[1]]}
  end

  def octopuses_to_update
    coords_to_update.map { |y,x| find_octopus(y, x) }.select { |octopus| !octopus.has_flashed } 
  end

  def find_octopus(y, x)
    pod.find { |octopus| octopus.y == y && octopus.x == x }
  end

  def update_neighbours
    loop do 
      @coords_to_update = []
      pod.each { |octopus| @coords_to_update << octopus.neighbours if octopus.need_to_update_neighbours }
      pod.each { |octopus| octopus.reset_need_to_update_neighbours }
      increment_energy(octopuses_to_update)
      break if @coords_to_update.length == 0
    end
  end

  def update_flash_count
    @flash_count += pod.select {|octopus| octopus.has_flashed }.count
    pod.each { |octopus| octopus.reset_flash }
  end

  def increment_energy(octopi)
    octopi.each { |octopus| octopus.increment_energy }
  end
end
