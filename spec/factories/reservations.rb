# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reservation do
    date Date.today + 1
    time_in Time.now
    time_out Time.now + 15.minutes
    room "Ops"
    recur ""
    recurrance_id ""
    recurrance_duration 0
    createdby "brian@goodinc.com"
  end
end
