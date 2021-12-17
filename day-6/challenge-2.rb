class Challenge 

  attr_reader :school, :population
  
  def initialize
    @school = File.read("input.txt").split(",").map(&:to_i)
    @population = {
      0 => school.count(0),
      1 => school.count(1),
      2 => school.count(2),
      3 => school.count(3),
      4 => school.count(4),
      5 => school.count(5),
      6 => school.count(6),
      7 => school.count(7),
      8 => school.count(8),
    }
  end

  def population_after(days)
    days.times { advance_one_day }
    population.sum {|h, v| v }
  end
    
  private
    
  def advance_one_day
    next_population = {
      0 => population[1],
      1 => population[2],
      2 => population[3],
      3 => population[4],
      4 => population[5],
      5 => population[6],
      6 => population[7],
      7 => population[8],
      8 => population[0],
    }

    next_population[6] += population[0]

    @population = next_population
  end
end

