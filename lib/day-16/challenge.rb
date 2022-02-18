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
    p versions
    versions.sum
  end
  
  def operator
    length_type_id = decimal_value_of_first(1, binary)
    if length_type_id == 0 # TOTAL LENGTH OF CHILDREN
      length_of_children = decimal_value_of_first(15, binary)
      children = first(length_of_children, binary)
      
      version = decimal_value_of_first(3, children)
      @versions << version
      type_id = decimal_value_of_first(3, children)

      # Removes a literal
      if type_id == 4
        number=[1]
        until number[0] == "0"
          number = first(5, children)
        end
      end

      version = decimal_value_of_first(3, children)
      @versions << version
      type_id = decimal_value_of_first(3, children)
    end
    
    if length_type_id == 1 # NUMBER OF CHILDREN
      total_children = decimal_value_of_first(11, binary)
      children = binary
      current_children = 0

      until current_children == total_children
        version = decimal_value_of_first(3, children)
        @versions << version
        type_id = decimal_value_of_first(3, children)
        number=[1]
        until number[0] == "0"
          number = first(5, children)
        end
        current_children += 1
      end
    end
  end


  private

  def first(digits, binary)
    binary.shift(digits)
  end

  def decimal_value_of_first(digits, binary)
    binary.shift(digits).join.to_i(2)
  end
end