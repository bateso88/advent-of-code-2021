# fold along x=655
coords = File.read("input.txt").split.map { |line| line.split(",").map(&:to_i) }

coords.map! do |x,y|
  if x > 655
    [655 - (x - 655), y]
  else
    [x, y]
  end
end

p coords.uniq.length
