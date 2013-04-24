class CreateExclusions < ActiveRecord::Migration
  def change
    create_table :exclusions do |t|
      t.date :reserv_exclusion
      t.integer :recurrance_id
      t.timestamps
    end

  end
end
