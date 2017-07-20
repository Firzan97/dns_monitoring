class RenameTypeToTypeAnswer < ActiveRecord::Migration[5.1]
  def change
  	rename_column :answers, :type, :typeAnswer
  end
end
