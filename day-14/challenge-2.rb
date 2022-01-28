class Challenge

  attr_reader :polymer, :pairs, :codes

  def initialize
    @polymer = "NBOKHVHOSVKSSBSVVBCS"
    @pairs = @polymer.chars.each_cons(2).map { |a,b| [a,b] }
                            .each_with_object(Hash.new(0)) { |letter, new_hash| new_hash[letter] += 1 }
    @codes = File.read("input.txt").split("\n").map { |line| line.split(" -> ") }.map { |line| [line[0].chars, line[1]] }.to_h
  end

  def result 
    40.times { step }
    totals = Hash.new(0)
    pairs.each { |(a,b),count| totals[a] += count }
    totals[polymer.chars.last] += 1
    min,max = totals.values.minmax
    p totals
    p max - min
  end

  def step
    next_pairs = Hash.new(0)

    pairs.each do |k, v|
      next_pairs[[k[0], codes[k]]] += v
      next_pairs[[codes[k], k[1]]] += v
    end

    @pairs = next_pairs
  end
end

