class DropLog < ActiveRecord::Migration[5.1]
  def change
  	
    drop_table :logs
  end
end
