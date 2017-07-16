class AddQueryToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :query, :string
  end
end
