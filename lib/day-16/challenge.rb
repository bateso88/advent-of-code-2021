class Packet
  def initialize(binary)
    @binary = binary
    @version = decimal_value_of_first(3)
    
  end
  
  def decimal_value_of_first(digits)
    binary.shift(digits).join.to_i(2)
  end
end

class Challenge
  attr_reader :binary, :versions

  def initialize(number = File.read("input.txt"))
    # "8A004A801A8002F478"
    # "620080001611562C8802118E34"
    @binary = number.hex.to_s(2).rjust(number.size*4, '0').chars
    @versions = []
    # @layer = 1
  end

  def step
    # show
    version = decimal_value_of_first(3)
    @versions << version
    type_id = decimal_value_of_first(3)
    # p version
    # p type_id
    show
    # p "do_something" if literal?(type_id)
    if !literal?(type_id) 
      length_type_id = binary.shift.to_i
      p length_type_id
      if length_type_id == 0 
        p "length of sub-packets"
        p length_of_sub_packets = decimal_value_of_first(15)
      else
        p "number of sub-packets"
        p number_of_sub_packets = decimal_value_of_first(11)
        p version = decimal_value_of_first(3)
        @versions << version
        p type_id = decimal_value_of_first(3)
        show
        # in this example is operator so take length_type which is 1
        binary.shift.to_i
        p decimal_value_of_first(11)

        p version = decimal_value_of_first(3)
        @versions << version
        p type_id = decimal_value_of_first(3)
        show
        # length_type id is 0 
        binary.shift.to_i
        p decimal_value_of_first(15)
        
        p version = decimal_value_of_first(3)
        @versions << version
        p type_id = decimal_value_of_first(3)        
      end
      show
    end

  end

  private

  def show 
    p binary.join
  end

  def literal?(type_id)
    type_id == 4
  end

  def decimal_value_of_first(digits)
    binary.shift(digits).join.to_i(2)
  end
end