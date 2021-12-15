boards = File.read("input.txt").split.each_slice(25).map { |num| num.map(&:to_i) }
numbers = [
            72,86,73,66,37,76,19,40,77,42,48,62,46,3,95,17,97,41,10,14,83,90,12,23,81,98,
            11,57,13,69,28,63,5,78,79,58,54,67,60,34,39,84,94,29,20,0,24,38,43,51,64,18,
            27,52,47,74,59,22,85,65,80,2,99,70,33,91,53,93,9,82,8,50,7,56,30,36,89,71,21,
            49,31,88,26,96,16,1,75,87,6,61,4,68,32,25,55,44,15,45,92,35
          ]

def has_won?(board) 
  rows = board.each_slice(5).map { |row| row }
  (rows + rows.transpose).any? { |combo| combo.sum == 0 }
end

winners = []

numbers.each do |pick| 
  boards.map! { |board| board.map { |num| num == pick ? 0 : num }}
  # boards.each { |board| winners << {board: board, pick: pick, score: (board.sum * pick)} if has_won?(board) }
  boards.reject! {|board| has_won?(board)}
  return {board: board, pick: pick, score: (board.sum * pick)} if boards.length == 1
end

p winners.first
p winners.last