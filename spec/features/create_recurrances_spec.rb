require 'spec_helper'


feature 'Authorized user can create recurring reservations' do

  it "creates a reservation with recurrance and a new recurrance is created" do
    visit '/sessions/create'
    visit '/reservations'
    reserv_with_recurrance = FactoryGirl.create(:reservation, recur: "Weekly", room: "GoodCorps",
                                                recurrance_duration: '4', id: 150)
    @new_recurrance = Recurrance.find_by_parent_id(150)
    @new_recurrance.start_date.should eq(reserv_with_recurrance.date)
    #@new_recurrance.time_in.should eq(reserv_with_recurrance.time_in)
    #@new_recurrance.time_out.should eq(reserv_with_recurrance.time_out)
    @new_recurrance.parent_id.should eq(reserv_with_recurrance.recurrance_id.to_s)    
    @new_recurrance.recur.should eq('Weekly')
    @new_recurrance.duration.should eq(4)
    @new_recurrance.room.should eq('GoodCorps')
  end

  it "Recurrance then generates reservations" do 
    visit '/sessions/create'
    visit '/reservations'
    reserv_with_recurrance = FactoryGirl.create(:reservation, recur: "Weekly", room: 'GoodCorps',
                                                recurrance_duration: '4', id: 150)
    visit '/reservations?limit=3'
    @oneweek = Reservation.find_by_date(reserv_with_recurrance.date + 7.days)
    @oneweek.recurrance_id.should eq(150)
    @twoweek = Reservation.find_by_date(reserv_with_recurrance.date + 14.days)
    @twoweek.recurrance_id.should eq(150)
    @threeweek = Reservation.find_by_date(reserv_with_recurrance.date + 21.days)
    @threeweek.recurrance_id.should eq(150)
  end

  it "Recurrances outside the calendar are not created" do 
    visit '/sessions/create'
    visit '/reservations'
    reserv_with_recurrance = FactoryGirl.create(:reservation, recur: "Weekly", room: 'GoodCorps',
                                                recurrance_duration: '4', id: 150)
    visit '/reservations'
    @oneweek = Reservation.find_by_date(reserv_with_recurrance.date + 7.days)
    @oneweek.should_not be nil 
    @twoweek = Reservation.find_by_date(reserv_with_recurrance.date + 14.days)
    @twoweek.should be nil
    @threeweek = Reservation.find_by_date(reserv_with_recurrance.date + 21.days)
    @threeweek.should be nil
    @last = Reservation.find_by_date(reserv_with_recurrance.date + 28.days)
    @last.should be nil
  end

end