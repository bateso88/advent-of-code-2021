class Challenge 

  attr_reader :test_data, :training_data

  def initialize
    @test_data = File.read("input.txt")
                     .split("\n")
                     .map { |set| set.split(" | ")[1].split.map{ |num| num.chars.sort.join }}

    @training_data = File.read("input.txt")
                        .split("\n")
                        .map { |set| set.split(" | ")[0].split.map{ |num| num.chars.sort.join }}
    @set=[]
  end

  def result 
    @result ||= training_data.map.with_index do |set, i|
      code = calculate_code(set)
      test_data[i].map { |num| code.key(num) }.join.to_i
    end
    @result.sum
  end

  private

  def calculate_code(set)
    @set = set.map { |num| num.chars }
    code = {
      1 => set_number(2, []),
      4 => set_number(4, []),
      7 => set_number(3, []),
      8 => set_number(7, []),
    }

    code[3] = set_number(5, code[7])
    code[9] = set_number(6, code[4])
    @set.reject! { |num| code.values.include?(num) }
    code[0] = set_number(6, code[7])
    @set.reject! { |num| code.values.include?(num) }
    code[6] = set_number(6, [])
    @set.reject! { |num| code.values.include?(num) }
    code[2] = set_number(5, code[1]-code[6])
    @set.reject! { |num| code.values.include?(num) }
    code[5] = set_number(5, [])

    code.each { |k, v| code[k] = v.join }
  end

  def set_number(length, included_shape)
    @set.select { |num| num.length == length && (included_shape - num).empty? }[0]
  end
end

