class CreatePerformances < ActiveRecord::Migration[5.1]
  def change
    create_table :performances do |t|
      t.integer :responsetime

      t.timestamps
    end
  end
end
