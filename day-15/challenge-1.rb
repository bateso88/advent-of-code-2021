class Challenge

  END_COORDS = [99, 99]

  attr_reader :cave, :unvisited_nodes

  def initialize
    @cave = File.read("input.txt").split("\n").map { |row| row.chars.map(&:to_i) }
    @unvisited_nodes = {}
    cave.length.times { |y| cave[-1].length.times { |x| @unvisited_nodes[[y, x]] = 99999 }}
    unvisited_nodes[[0, 0]] = 0
  end
  
  def result
    loop do
      current_coords, current_risk = unvisited_nodes.min_by{ |k, v| v } # Smallest total risk
      unvisited_neighbours(current_coords).each { |neighbour| update_risk(neighbour, current_risk) }
      break if current_coords == END_COORDS
      unvisited_nodes.delete(current_coords)
    end
    unvisited_nodes[END_COORDS]
  end

  private

  def update_risk(neighbour, current_risk)
    unvisited_nodes[neighbour] = current_risk + risk(neighbour) if unvisited_nodes[neighbour] > current_risk + risk(neighbour)
  end

  def unvisited_neighbours(coords)
    y, x = coords
    neighbours = []
    neighbours << [y - 1, x] if y > 0 && unvisited_nodes.include?([y - 1, x])
    neighbours << [y, x - 1] if x > 0 && unvisited_nodes.include?([y, x - 1])
    neighbours << [y + 1, x] if y < END_COORDS[0] && unvisited_nodes.include?([y + 1, x])
    neighbours << [y, x + 1] if x < END_COORDS[1] && unvisited_nodes.include?([y, x + 1])
    neighbours
  end

  def risk(coords)
    cave[coords[0]][coords[1]]
  end
end