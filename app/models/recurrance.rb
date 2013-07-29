class Recurrance < ActiveRecord::Base
  belongs_to :reservation
  has_many :exclusions
  attr_accessible :duration, :room, :start_date, :time_in, :time_out, :recur, :parent_id 


  def to_s
  	"Recurrance #{id} in #{room} starting #{start_date} parent_id #{parent_id}"
  end

end
