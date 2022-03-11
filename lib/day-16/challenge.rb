# class Challenge
#   attr_reader :binary, :sum_of_versions

#   def initialize(number = File.read("input.txt"))
#     @binary = number.hex.to_s(2).rjust(number.size*4, '0').chars
#     @sum_of_versions = 0 
#   end

#   def result(packet = binary)
#     version = decimal_value_of_first(3, packet)
#     @sum_of_versions += version
#     type_id = decimal_value_of_first(3, packet)

#     if type_id == 4 # LITERAL
#       while first(1, packet) == "1"
#         first(4, packet)
#       end
#       first(4, packet)
#     else 
#       operator(packet) # OPERATOR
#     end
    
#     sum_of_versions
#   end
  
#   def operator(packet)
#     if packet.shift == "0" # TOTAL LENGTH OF PACKET
#       packet_length = decimal_value_of_first(15, packet)
#       sub_packet = first(packet_length, packet)

#       until sub_packet.empty?
#         result(sub_packet)
#       end

#     else # NUMBER OF SUB PACKETS
#       packet_count = decimal_value_of_first(11, packet)

#       packet_count.times do
#         result(packet)
#       end
#     end
#   end


#   private

#   def first(digits, binary_number)
#     binary_number.shift(digits)
#   end

#   def decimal_value_of_first(digits, binary_number)
#     binary_number.shift(digits).join.to_i(2)
#   end
# end

###### ...nearly there. The solution from above is very close to the correct answer for part 1. To come back to...


###### SOLUTION BELOW FROM https://www.reddit.com/r/adventofcode/comments/rhj2hm/2021_day_16_solutions/houksni/?context=3

$version = 0

def parse_packet(packet)
  packet_version = packet.shift(3).join.to_i(2)
  $version += packet_version
  type_id = packet.shift(3).join.to_i(2)

  if type_id == 4 # literal packet
    msg = []
    while packet.shift == "1"
      msg.append(*packet.shift(4))
    end
    msg.append(*packet.shift(4))
    return [msg.join.to_i(2), packet]

  else # operator

    # length type == bits
    if packet.shift == "0"
      packet_len = packet.shift(15).join.to_i(2)
      sub_packet = packet.shift(packet_len)
      result = []
      until sub_packet.empty?
        sub_result, sub_packet = parse_packet(sub_packet)
        result << sub_result
      end

    # length type == packet count
    else
      packet_count = packet.shift(11).join.to_i(2)
      result = []
      packet_count.times do
        sub_result, packet = parse_packet(packet)
        result << sub_result
      end
    end

    case type_id
    when 0; return [result.sum, packet]
    when 1; return [result.reduce(&:*), packet]
    when 2; return [result.min, packet]
    when 3; return [result.max, packet]
    when 5; return [result.reduce(&:>) ? 1 : 0, packet]
    when 6; return [result.reduce(&:<) ? 1 : 0, packet]
    when 7; return [result.reduce(&:==) ? 1 : 0, packet]
    end
  end
end

# input = ARGF.read.strip.chars.map{|c| c.hex.to_s(2).rjust(4, "0").chars}.flatten
hex_number = File.read("input.txt")
input = hex_number.hex.to_s(2).rjust(hex_number.size*4, '0').chars.flatten

puts "Part 2: #{parse_packet(input).first}"
puts "Part 1: #{$version}"