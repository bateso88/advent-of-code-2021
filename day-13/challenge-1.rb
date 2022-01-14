# fold along x=655
lines = File.read("input.txt").split.map { |line| line.split(",").map(&:to_i) }

p lines