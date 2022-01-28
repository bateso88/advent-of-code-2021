class Challenge

  attr_reader :polymer, :codes

  def initialize
    @polymer = "NBOKHVHOSVKSSBSVVBCS"
    @codes = File.read("input.txt").split("\n").map { |line| line.split(" -> ") }.map { |line| [line[0].chars, line[1]] }
  end

  def result 
    10.times { step }
    count = polymer.chars.each_with_object(Hash.new(0)) { |letter, new_hash| new_hash[letter] += 1 }
    count.max_by { |k,v| v }[1] - count.min_by { |k,v| v }[1]
  end

  def step
    @polymer = polymer.chars.each_cons(2).map { |pair| codes.find { |code| code[0] == pair }}
    polymer.map! { |code| [code[0][0], code[1], code[0][1]] }
    first_item = polymer.shift
    polymer.each{ |item| item.shift }
    @polymer = (first_item + polymer).flatten.join
  end
end

