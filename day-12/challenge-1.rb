class Point 

attr_reader :neighbours, :name, :category

  def initialize(name, lines)
    @name = name
    @touched = false
    @neighbours = lines.select { |line| line.include?(@name) }.flatten.reject{ |value| value == name }.sort
    @category = category
  end

  def category
    return "START" if name == "start"
    return "END" if name == "end"
    return "SMALL" if name == name.downcase
    return "BIG" if name == name.upcase
  end
end

class Challenge

  attr_reader :lines, :points, :paths, :start_point

  def initialize
    @lines = File.read("input.txt").split.map { |line| line.split("-") }
    @points = lines.flatten.uniq.map{ |name| Point.new(name, lines)}
    @paths = []
    @start_point = points.find{ |point| point.category == "START" }
    @end_point = points.find{ |point| point.category == "END" }
  end

  def create_path
    paths << start_point

    #### NEEDS A LOT OF WORK 
    #Something like this but obvs need to be iterative
    new_paths = [
      [paths[-1], find_point(paths[-1].neighbours[0])], 
      [paths[-1], find_point(paths[-1].neighbours[1])], 
      [paths[-1], find_point(start_point.neighbours[2])],
    ]
    
  end

  def find_point(name)
    points.find { |point| point.name == name }
  end
end
