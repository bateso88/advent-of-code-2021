boards = File.read("boards.txt").split.each_slice(25).map { |num| num.map(&:to_i) }
picks = File.read("picks.txt").split(",").map(&:to_i)

def has_won?(board) 
  rows = board.each_slice(5).map { |row| row }
  (rows + rows.transpose).any? { |combo| combo.sum == 0 }
end

picks.each do |pick| 
  boards.map! { |board| board.map { |num| num == pick ? 0 : num }}
        .each { |board| return p "BINGO: #{board.sum * pick}" if has_won?(board) }
end
