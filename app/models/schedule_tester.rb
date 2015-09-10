class ScheduleTester

  def initialize(test_period, successful_array, week_array)
    @test_period = test_period
    @successful_array = successful_array
    @week_array = week_array
  end

  def test

    # probably better way to write this method
    # essentially just want to return true if it doesn't break and false if it does
    array = []
    successful_array.each do |s|
      s.each_with_index do |p, index|
        array.push('break') if test_period[index] == p
      end
    end

    if array.blank? 
      if week_array.present?
        test_past ? (return true) : (return false)
      else
        return true
      end
    else
      return false
    end

    array.blank? ? (return true) : (return false)
  end

  def test_me
    # MAJOR CHECK OF THE SQL
    last_three_schedules = SchedulePeriod.joins(:days).where(
      "schedule_periods.group_id = #{group_id} AND
       days.date >= #{relevant_day}").group("days.date")

    array = []
    last_three_schedules.values.each do |s|
      # saying to break the array if there is some overlap between this schedule and one of the last three
      array.push('break') if (s & successful_array).present?
    end
    # if any of them returned 'break', then move on to the next schedule
    array.blank? ? (return true) : (return false)
  end

  private

  attr_reader :test_period, :successful_array, :week_array

  def group_id
    
  end

  def relevant_day 
    schedule_period.period_date - 3.days
  end

  def test_past
    group_activities = []
    week_array.each do |w|
      day_array = []
      (0..(w.first.count - 1)).each do |i|
        group_array = []
        w.each do |p|
          group_array.push(p[i])
        end
        day_array.push(group_array)
      end
      group_activities.push(day_array)
    end

    break_array = []
    group_activities.each do |ga|
      ga.each_with_index do |g, index|
        break_array.push('break') if test_period[index].in? g
      end
    end
    break_array.blank? ? true : false
  end

  # TONS OF DIFFERENT THINGS THAT CAN BE TESTED
  # 1... Weather
  # 2... Recent Schedule
  # 3... Need a certain amount of likable activities
  # 4... Want to minimize distance for periods between breaks (done w/ dist formula using coordinates)
  # 5... 
end