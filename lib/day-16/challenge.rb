class Challenge
  attr_reader :binary, :versions

  def initialize(number = File.read("input.txt"))
    @binary = number.hex.to_s(2).rjust(number.size*4, '0').chars
    @versions = []
  end

  def result(binary)
    version = decimal_value_of_first(3, binary)
    @versions << version
    type_id = decimal_value_of_first(3, binary)

    if type_id == 4
      number=[] # NOT DOING ANYTHING WITH THIS YET
      while first(1, binary) == "1"
        number << first(4, binary)
      end
      number << first(4, binary)
    else 
      operator
    end
    
    p versions
    versions.sum
  end
  
  def operator
    length_type_id = binary.shift
    if length_type_id == "0" # TOTAL LENGTH OF CHILDREN
      packet_length = decimal_value_of_first(15, binary)
      children = first(packet_length, binary)

      #SHOULD BE ABLE TO DO SOMETHING LIKE THIS INSTEAD OF THE REMAINDER OF THIS IF FUNCTION
      # until children.empty?
      #   result(children)
      # end
      ############### LOOK AT: https://www.reddit.com/r/adventofcode/comments/rhj2hm/2021_day_16_solutions/houksni/?context=3
      
      version = decimal_value_of_first(3, children)
      @versions << version
      type_id = decimal_value_of_first(3, children)

      # Removes a literal
      if type_id == 4
        number=[] # NOT DOING ANYTHING WITH THIS YET
        while first(1, children) == "1"
          number << first(4, children)
        end
        number << first(4, children)
      end

      version = decimal_value_of_first(3, children)
      @versions << version
      type_id = decimal_value_of_first(3, children)
    end
    
    if length_type_id == "1" # NUMBER OF CHILDREN
      total_children = decimal_value_of_first(11, binary)
      children = binary
      current_children = 0

      until current_children == total_children #LOOPS THROUGH ALL "LITERAL" CHILDREN
        version = decimal_value_of_first(3, children)
        @versions << version
        type_id = decimal_value_of_first(3, children)
        
        # Removes a literal
        if type_id == 4
          number=[] # NOT DOING ANYTHING WITH THIS YET
          while first(1, children) == "1"
            number << first(4, children)
          end
          number << first(4, children)
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