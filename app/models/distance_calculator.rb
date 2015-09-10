class DistanceCalculator

  def initialize(schedule)
    @schedule = schedule
  end

  # will return an array of hashes of scheduled activity and distnce to get there
  def get_distance
    (1..(schedule.count - 1)).map do |i|
      {schedule[i]=> distance(schedule[i], schedule[i-1])}
    end
  end

  private

  attr_reader :schedule

  def distance(one, two)
    Math.sqrt(((two[0] - one[0])^2 + (two[1] - one[1])^2)).round(2)
  end
end
