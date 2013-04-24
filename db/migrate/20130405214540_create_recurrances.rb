class CreateRecurrances < ActiveRecord::Migration
  def change
    create_table :recurrances do |t|
      t.date :start_date
      t.time :time_in
      t.time :time_out
      t.integer :duration
      t.string :recur
      t.string :room

      t.timestamps
    end
  end
end
