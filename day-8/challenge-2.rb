codes = File.read("input.txt")
            .split("\n")
            .map { |set| set.split(" | ")[1].split.map{ |num| num.chars.sort.join }}

training_data = File.read("input.txt")
                    .split("\n")
                    .map { |set| set.split(" | ")[0].split.map{ |num| num.chars.sort.join }}

def calculate(set)
  set.map! { |num| num.chars }
  number = {
    1 => set.select { |num| num.length == 2 }[0],
    4 => set.select { |num| num.length == 4 }[0],
    7 => set.select { |num| num.length == 3 }[0],
    8 => set.select { |num| num.length == 7 }[0],
  }

  number[3] = set.select { |num| num.length == 5 && (number[7] - num).empty? }[0]
  number[9] = set.select { |num| num.length == 6 && (number[4] - num).empty? }[0]
  set.reject! { |num| number.values.include?(num)}
  number[0] = set.select { |num| num.length == 6 && (number[7] - num).empty? }[0]
  number[6] = set.select { |num| num.length == 6 && !(number[7] - num).empty? }[0]
  number[5] = set.select { |num| num.length == 5 && (num - number[6]).empty? }[0]
  number[2] = set.select { |num| num.length == 5 && !(num - number[6]).empty? }[0]

  number.each { |k, v| number[k] = v.join }
end

res = training_data.map.with_index do |set, i|
  numbers = calculate(set)
  codes[i].map { |num| numbers.key(num) }.join.to_i
end

p res.sum

