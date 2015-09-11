class Camp < ActiveRecord::Base
  has_many :activities_venues, through: :venues
  has_many :activities, through: :activities_venues
  has_many :groups
  has_many :staff_members, through: :staff_members_roles
  has_many :venues

  def organize
    acts = activities.uniq.map(&:name)

    #choose one group of 16
    #choose another group of 16 and make sure it fits rules
    #do same until there are 6 and then set!
    #could also potentially do through acts.permutation(n)

    week_array = []

    until week_array.count == 3
      successful_array = []
      i = 0
      until successful_array.count == 6
        puts i
        i += 1
        test_period = acts.shuffle.first(16)
        if ScheduleTester.new(test_period, successful_array, week_array).test
           successful_array.push(test_period)
        end
        week_array.push(successful_array) if successful_array.count == 6
      end
    end
    return week_array
  end

  def marker_json
    usable_venues = venues.where.not(coordinates: nil)
    q = usable_venues.map { |v| {lat: v.latitude, lng: v.longitude, infowindow: "#{v.name}"} }

    return q.to_json
  end
end