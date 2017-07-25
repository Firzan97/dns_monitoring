class AddDateMalayToPerformances < ActiveRecord::Migration[5.1]
  def change
    add_column :performances, :date_malay, :datetime
  end
end
