class AddAuthorityToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :authority, :string
  end
end
