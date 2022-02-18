school = File.read("input.txt").split(",").map(&:to_i)

80.times{ school.map! {|fish| fish == 0 ? [6,8] : fish-1 }.flatten! }

p school.length