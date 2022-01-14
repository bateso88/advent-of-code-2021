class Cave 

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
    lines = File.read("input.txt").split.map { |line| line.split("-") }
    @caves = lines.flatten.uniq.map{ |name| Cave.new(name, lines)}
    @paths = [[find_cave("start")]]
  end

  def result
    until paths.all? { |path| path[-1].name == "end"}
      iterate_paths
    end
    show_paths
    paths.length
  end

  private

  attr_reader :caves, :paths

  def iterate_paths
    updated_paths = []

    paths.each do |path|
      last_cave = path[-1]

      if last_cave.name == "end"
        updated_paths << path
        next
      end

      last_cave.neighbours.each do |neighbour|
        next_cave = find_cave(neighbour)

        next if already_visited?(next_cave, path) && small?(next_cave)

        updated_paths << extended_path(path, next_cave)
      end
    end

    @paths = updated_paths
  end

  def already_visited?(cave, path)
    path.include?(cave) && cave.category == "SMALL"
  end

  def small?(cave)
    cave.category == "SMALL"
  end

  def extended_path(path, cave)
    new_path = path.clone
    new_path << cave
  end

  def show_paths
    paths.each { |path| p path.map { |cave| cave.name }}
    return
  end

  def find_cave(name)
    caves.find { |cave| cave.name == name }
  end
end
