def calculate(gas) # 0 for O2 and -1 for CO2
  data = File.read("input.txt").split.map(&:chars).map {|bit| bit.map(&:to_i) }
  i=0
  until data.length == 1 
    data.transpose[i].sum >= data.length.to_f/2 ? x = gas + 1 : x = -gas
    data.select! { |bn| bn[i] == x }
    i+=1
  end
  data.join.to_i(2)
end

p life_support_rating = calculate(0) * calculate(-1)