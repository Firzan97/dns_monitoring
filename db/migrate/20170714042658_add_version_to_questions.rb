class AddVersionToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :version, :string
  end
end
