def calculate(gas) # 0 for o2 and -1 for co2
  data = File.read("input.txt").split.map(&:chars).map {|arr| arr.map(&:to_i) }
  i=0
  until data.length == 1 
    data.transpose[i].sum >= data.length.to_f/2 ? x = gas+1 : x = -gas
    data.select! { |arr| arr[i] == x }
    i+=1
  end
  data.join.to_i(2)
end

p life_support_rating = calculate(0) * calculate(-1)