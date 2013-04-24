# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recurrance do
    start_date Date.today + 1.day
    time_in Time.now
    time_out Time.now + 30.minutes
    duration 4
    parent_id 5
    recur "Weekly"
    room "GoodCorps"
  end
end
