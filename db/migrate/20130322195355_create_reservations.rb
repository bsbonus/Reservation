class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.date :date
      t.time :time_in
      t.time :time_out
      t.string :room
      t.string :recur
      t.integer :recurrance_duration

      t.timestamps
    end
  end
end
