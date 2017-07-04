class AddQuestionRefToDetails < ActiveRecord::Migration[5.1]
  def change
    add_reference :details, :question, foreign_key: true
  end
end
