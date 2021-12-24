lines = File.read("input.txt").split.map { |row| row.chars }

def is_opening?(bracket)
  bracket == "(" || bracket == "[" || bracket == "{" || bracket == "<"
end

closing_bracket = { "(" => ")", "[" => "]", "{" => "}", "<" => ">" }
bracket_score = { ")" => 3, "]" => 57, "}" => 1197, ">" => 25137 }
errors = []
score = 0

lines.each do |line|
  open_brackets = []
  line.each.with_index do |bracket, index| 
    if is_opening?(bracket)
      open_brackets << bracket
    else
      if bracket != closing_bracket[open_brackets.pop] 
        errors << bracket
        break
      end
    end
  end
end

errors.each { |bracket| score += bracket_score[bracket]}

p errors

p score
