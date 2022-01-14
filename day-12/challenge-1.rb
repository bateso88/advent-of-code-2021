class Point 

attr_reader :neighbours, :name, :category

  def initialize(name, lines)
    @name = name
    @touched = false
    @neighbours = lines.select { |line| line.include?(@name) }.flatten.reject{ |value| value == name }.sort
    @category = category
  end

  def category
    return "SMALL" if name == name.downcase
    return "BIG" if name == name.upcase
  end
end

class Challenge

  def initialize
    @lines = File.read("input.txt").split.map { |line| line.split("-") }
    @points = lines.flatten.uniq.map{ |name| Point.new(name, lines)}
    @paths = [[find_point("start")]]
  end

  def result
    until paths.all? { |path| path[-1].name == "end"}
      iterate_paths
    end
    show_paths
    p paths.length
  end

  private

  attr_reader :lines, :points, :paths

  def iterate_paths
    new_paths = []

    paths.each do |path|
      # skip (and keep) path if its reached the end
      if path[-1].name == "end"
        new_paths << path
        next
      end

      path[-1].neighbours.each do |neighbour|
        new_point = find_point(neighbour)

        # skip point if it is already in the path AND it is small
        next if path.include?(new_point) && new_point.category == "SMALL"
        
        new_paths << extended_path(path, new_point)
      end
    end

    @paths = new_paths
  end

  def extended_path(path, point)
    new_path = path.clone
    new_path << point
  end

  def show_paths
    paths.each { |path| p path.map { |point| point.name }}
    return
  end

  def find_point(name)
    points.find { |point| point.name == name }
  end
end
