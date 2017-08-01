class DropChange < ActiveRecord::Migration[5.1]
  def change
  	drop_table :changes
  end
end
