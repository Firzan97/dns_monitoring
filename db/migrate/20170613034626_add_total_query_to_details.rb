class AddTotalQueryToDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :details, :total_query, :integer
  end
end
