class AddCreatedByColumnToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :createdby, :string
  end
end
