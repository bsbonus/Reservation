class AddRecurranceIdToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :recurrance_id, :intger
  end
end
