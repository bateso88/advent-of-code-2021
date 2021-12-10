boards = File.read("input.txt").split.each_slice(25).map { |num| num.map(&:to_i) }
numbers = [
            72,86,73,66,37,76,19,40,77,42,48,62,46,3,95,17,97,41,10,14,83,90,12,23,81,98,
            11,57,13,69,28,63,5,78,79,58,54,67,60,34,39,84,94,29,20,0,24,38,43,51,64,18,27,
            52,47,74,59,22,85,65,80,2,99,70,33,91,53,93,9,82,8,50,7,56,30,36,89,71,21,49,31,
            88,26,96,16,1,75,87,6,61,4,68,32,25,55,44,15,45,92,35
          ]

def win?(board) 
  rows = board.each_slice(5).map { |row| row }
  combos = rows + rows.transpose
  combos.any? { |combo| combo.sum == -5 }
end

def calculate_score(board, final_number) 
  p "BINGO!"
  p board.select { |number| number > 0 }.sum * final_number
  p final_number
end

numbers.each do |pick| 
  boards.map! { |board| board.map { |num| num == pick ? -1 : num }}
  boards.each { |board| return calculate_score(board, pick) if win?(board) }
end
