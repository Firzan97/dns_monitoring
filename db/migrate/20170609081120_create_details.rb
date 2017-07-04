class CreateDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :details do |t|
      t.decimal :average
      t.decimal :maximum
      t.decimal :minimum
      t.decimal :status

      t.timestamps
    end
  end
end
