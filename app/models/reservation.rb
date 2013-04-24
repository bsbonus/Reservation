class Reservation < ActiveRecord::Base
  has_one :recurrance
  attr_accessible :date, :recur, :recurrance_duration, :room, :time_in, :time_out, :id, :recurrance_id
  validates_presence_of :room, :date
  validate :validate_start_time
  validate :validate_previous_reservations
  validate :minimum_duration
  validate :validate_date
  after_save :update_attr
  after_create :create_recurrance 

  ROOMLIST = %w[Ops GoodCorps Interview1]
  RECURRANCE_OPTIONS = %w[None Weekly Bi-Weekly Monthly]
  DURATION_OPTIONS = %w[ 0 1 2 3 4 8 12 24 indefinite]

    def update_attr
      if recurrance_id == nil
        self.update_attributes(:recurrance_id => self.id)
        self.save(:validate => false)
      end
    end

    def create_recurrance
      if recur == "Weekly"
        x = Recurrance.create(start_date: date, time_in: time_in, time_out: time_out, 
                          room: room, recur: recur, duration: recurrance_duration, parent_id: id )
      end
    end

    def validate_start_time
  	  if (time_in > time_out)
  	    errors.add(:time_in, "is after End time. What are you, traveling in time?") 
   	  end
    end

    def validate_date
      if date == nil 
        errors.add(:date, "You must choose a date")
      elsif date < Date.today
	      errors.add(:date, "Cannot reserve room in the past, son!")
	    end 
    end

    def minimum_duration
      minutes = 15 * 60
      if (time_out - time_in < minutes )
        errors.add(:time_out, "Ain't no meeting that's shorter than 15 minutes.")
      end
    end

    def validate_previous_reservations
	  conflicts = Reservation.where(:room => room, :date => date, 
                :time_in => time_in...time_out)
      errors.add(:room, "Room conflict") if conflicts.present?
    end
end
