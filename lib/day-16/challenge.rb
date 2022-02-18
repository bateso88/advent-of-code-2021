class Challenge
  attr_reader :binary, :versions

  def initialize(number = File.read("input.txt"))
    @binary = number.hex.to_s(2).rjust(number.size*4, '0').chars
    @versions = []
  end

  def result
    version = decimal_value_of_first(3, binary)
    @versions << version
    type_id = decimal_value_of_first(3, binary)
    
    operator if type_id != 4 
    versions.sum
  end
  
  def operator
    length_type_id = decimal_value_of_first(1, binary) #Not doing anything with this yet
    p length_of_children = decimal_value_of_first(15, binary)
    p children = first(length_of_children, binary)
    
    version = decimal_value_of_first(3, children)
    @versions << version
    type_id = decimal_value_of_first(3, children)
    if type_id == 4
      p children 
      number=[1]
      until number[0] != "0"
        number = first(5, children)
        p number
      end
    end
    version = decimal_value_of_first(3, children)
    @versions << version
    type_id = decimal_value_of_first(3, children)
    p versions


  end


  private

  def first(digits, binary)
    binary.shift(digits)
  end

  def decimal_value_of_first(digits, binary)
    binary.shift(digits).join.to_i(2)
  end
end