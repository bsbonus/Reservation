class Exclusion < ActiveRecord::Base
  attr_accessible :recurrance_id, :reserv_exclusion
  belongs_to :recurrance, :dependent => :delete
end
