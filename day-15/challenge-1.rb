class Challenge

  attr_reader :cave, :unvisited_nodes, :visited_nodes

  def initialize
    @cave = File.read("input.txt").split("\n").map { |row| row.chars.map(&:to_i) }
    @unvisited_nodes = {}
    @cave.each_with_index { |row, y| row.each_with_index { |risk, x| @unvisited_nodes[[y, x]] = 99999 }}
    unvisited_nodes[[0,0]] = 0
  end
  
  def result
    loop do
      # SET NODE WITH SMALLEST RISK VALUE AS CURRENT NODE
      coords, current_risk = unvisited_nodes.min_by{ |k, v| v }
      y, x = coords
      # FIND ALL UNVISITED NEIGHBOURS OF THE CURRENT NODE
      neighbours = []
      neighbours << [y - 1, x] if y > 0 && unvisited_nodes.include?([y - 1, x])
      neighbours << [y, x - 1] if x > 0 && unvisited_nodes.include?([y, x - 1])
      neighbours << [y + 1, x] if y < 99 && unvisited_nodes.include?([y + 1, x])
      neighbours << [y, x + 1] if x < 99 && unvisited_nodes.include?([y, x + 1])
      # IF RISK OF CURRENT NODE + RISK AT NEIGHBOUR IS LESS THAN TOTAL RISK CURRENTLY AT NEIGHBOUR, UPDATE NEIGHBOUR IN UNVISITED NODES
      neighbours.each do |neighbour|
        unvisited_nodes[neighbour] = current_risk + risk(neighbour) if unvisited_nodes[neighbour] > current_risk + risk(neighbour)
      end
      # REMOVE CURRENT NODE FROM UNVISITED NODES
      break if coords == [99,99] # Break once the final node has been visited
      unvisited_nodes.delete(coords)
    end
    unvisited_nodes[[99,99]]
  end

  def risk(coords)
    cave[coords[0]][coords[1]]
  end
end