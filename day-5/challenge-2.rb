class Challenge

  attr_reader :lines, :touched_coords, :coord_frequencies
  
  def initialize
    @lines = File.read("input.txt")
                 .split("\n")
                 .map { |line| line.split(" -> ").map { |coords| coords.split(",").map(&:to_i) }}
    @touched_coords = []
    @coord_frequencies = Hash.new(0)
  end

  def result
    lines.each { |line| add_coords(line)}
    touched_coords.each { |v| coord_frequencies[v] += 1 }
    @result ||= coord_frequencies.select { |k,v| v>1 }.length 
  end

  private

  def ints_between(a,b)
    a > b ? (b..a).to_a.reverse : (a..b).to_a
  end

  def add_coords(line)
    x = ints_between(line[0][0], line[1][0])
    y = ints_between(line[0][1], line[1][1])

    y.each { |y| touched_coords << "#{[x.sum,y]}" } if vertical(line)
    x.each { |x| touched_coords << "#{[x,y.sum]}" } if horizontal(line)
    x.count.times { |i| touched_coords << "#{[x[i],y[i]]}" } if diagonal(line)
  end

  def vertical(line)
    line[0][0] == line[1][0]
  end

  def horizontal(line)
    line[0][1] == line[1][1]
  end

  def diagonal(line)
    line[0][0] != line[1][0] && line[0][1] != line[1][1]
  end
end
