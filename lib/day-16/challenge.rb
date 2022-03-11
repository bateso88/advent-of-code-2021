class Challenge
  attr_reader :binary, :versions

  def initialize(number = File.read("input.txt"))
    @binary = number.hex.to_s(2).rjust(number.size*4, '0').chars
    @versions = []
  end

  def result(binary)
    p binary.join
    version = decimal_value_of_first(3, binary)
    p "Version: #{version}"
    @versions << version
    type_id = decimal_value_of_first(3, binary)
    p "type_id: #{type_id}"

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
      p "packet_length: #{packet_length}"
      sub_packet = first(packet_length, binary)

      until sub_packet.empty?
        result(sub_packet)
      end

    else # NUMBER OF CHILDREN
      packet_count = decimal_value_of_first(11, binary)
      p "packet_count: #{packet_count}"

      packet_count.times do
        result(binary)
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