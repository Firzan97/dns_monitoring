class AddTotalFailToDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :details, :total_fail, :integer
  end
end
