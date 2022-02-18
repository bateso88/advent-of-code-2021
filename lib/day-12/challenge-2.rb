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
      until paths.all? { |path| completed?(path) }
        iterate_paths
      end
      show_paths
      paths.length
    end

    private
  
    attr_reader :caves, :paths
  
    def iterate_paths
      @updated_paths = []
  
      paths.each do |path|
        calculate_extended_paths(path)
      end
  
      @paths = @updated_paths.clone
    end
  
    def calculate_extended_paths(path)
      if completed?(path)
        @updated_paths << path
        return
      end
      last_cave(path).neighbours.each do |neighbour|
        add_cave(path, neighbour)
      end
    end
  
    def add_cave(path, neighbour)
      next_cave = find_cave(neighbour)
      return if start?(next_cave)
      return if cannot_visit_small_cave_again?(path, next_cave)
      @updated_paths << extended_path(path, next_cave)
    end
  
    def extended_path(path, cave)
      new_path = path.clone
      new_path << cave
    end

    def cannot_visit_small_cave_again?(path, cave)
      have_visited_a_small_cave_twice?(path) && already_visited?(cave, path) && small?(cave)
    end

    def have_visited_a_small_cave_twice?(path)
      small_caves = path.select { |cave| cave.category == "SMALL" }
      return small_caves.length != small_caves.uniq.length
    end

    def start?(cave)
      cave.name == "start"
    end
  
    def completed?(path)
      last_cave(path).name == "end"
    end
  
    def already_visited?(cave, path)
      path.include?(cave)
    end
  
    def small?(cave)
      cave.category == "SMALL"
    end
  
    def show_paths
      paths.each { |path| p path.map { |cave| cave.name }}
      return
    end
  
    def find_cave(name)
      caves.find { |cave| cave.name == name }
    end
  
    def last_cave(path)
      path[-1]
    end
  end
  