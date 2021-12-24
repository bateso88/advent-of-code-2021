class Challenge

  ClosingBracket = { "(" => ")", "[" => "]", "{" => "}", "<" => ">" }
  BracketScore = { ")" => 1, "]" => 2, "}" => 3, ">" => 4 }

  attr_reader :lines

  def initialize
    @lines = File.read("input.txt").split.map { |row| row.chars }.select { |line| is_valid?(line) }
  end

  def result 
    scores[scores.length/2]
  end
  
  private 

  def scores 
    missing_brackets.map do |line|
      score = 0
      line.each { |bracket| score = (5 * score) + BracketScore[bracket] }
      score
    end.sort
  end

  def missing_brackets 
    lines.map do |line|
      open_brackets = []
      line.each { |bracket| is_opening?(bracket) ? open_brackets << bracket : open_brackets.pop }
      open_brackets.reverse.map { |bracket| ClosingBracket[bracket] }
    end
  end

  def is_opening?(bracket)
    bracket == "(" || bracket == "[" || bracket == "{" || bracket == "<"
  end

  def is_valid?(line)
    open_brackets = []
    line.each do |bracket| 
      if is_opening?(bracket)
        open_brackets << bracket
      else
        return false if bracket != ClosingBracket[open_brackets.pop] 
      end
    end
    true
  end

end
