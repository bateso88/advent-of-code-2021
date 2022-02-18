codes = File.read("input.txt")
            .split("\n")
            .map { |set| set.split(" | ")[1].split }.flatten

p codes.select { |code| code.length == 2 || code.length == 3 || code.length == 4 || code.length == 7 }.length