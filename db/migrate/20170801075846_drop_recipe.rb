class DropRecipe < ActiveRecord::Migration[5.1]
  def change
  	drop_table :recipes
  end
end
