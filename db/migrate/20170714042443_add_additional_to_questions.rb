class AddAdditionalToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :additional, :string
  end
end
