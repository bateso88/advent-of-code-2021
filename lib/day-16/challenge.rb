class Challenge
  attr_reader :binary, :sum_of_versions

  def initialize(number = File.read("input.txt"))
    @binary = number.hex.to_s(2).rjust(number.size*4, '0').chars
    @sum_of_versions = 0 
  end

  def result(packet = binary)
    version = decimal_value_of_first(3, packet)
    @sum_of_versions += version
    type_id = decimal_value_of_first(3, packet)

    if type_id == 4
      while first(1, packet) == "1"
        first(4, packet)
      end
      first(4, packet)
    else 
      operator(packet)
    end
    
    sum_of_versions
  end
  
  def operator(packet)
    length_type_id = packet.shift
    if length_type_id == "0" # TOTAL LENGTH OF PACKET
      packet_length = decimal_value_of_first(15, packet)
      sub_packet = first(packet_length, packet)

      until sub_packet.empty?
        result(sub_packet)
      end

    else # NUMBER OF SUB PACKETS
      packet_count = decimal_value_of_first(11, packet)

      packet_count.times do
        result(packet)
      end
    end
  end


  private

  def first(digits, binary_number)
    binary_number.shift(digits)
  end

  def decimal_value_of_first(digits, binary_number)
    binary_number.shift(digits).join.to_i(2)
  end
end