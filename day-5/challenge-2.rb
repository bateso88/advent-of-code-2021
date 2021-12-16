class Challenge

  attr_reader :lines, :all_coords, :sums
  
  def initialize
    @lines = File.read("input.txt")
                .split("\n")
                .map { |line| line.split(" -> ").map { |coords| coords.split(",").map(&:to_i) }}
    @all_coords = []
    @sums = Hash.new(0)
  end

  def result
    lines.each { |line| add_coords(line)}
    all_coords.each { |v| sums[v] += 1 }
    sums.select { |k,v| v>1 }.length 
  end

  private

  def ints_between(a,b)
    a > b ? (b..a).to_a.reverse : (a..b).to_a
  end

  def add_coords(line)
    x = ints_between(line[0][0], line[1][0])
    y = ints_between(line[0][1], line[1][1])

    y.each { |y| all_coords << "#{[x.sum,y]}" } if line[0][0] == line[1][0] #vertical
    x.each { |x| all_coords << "#{[x,y.sum]}" } if line[0][1] == line[1][1] #horizontal
    x.count.times { |i| all_coords << "#{[x[i],y[i]]}" } if line[0][0] != line[1][0] && line[0][1] != line[1][1] #diagonal
  end
end
