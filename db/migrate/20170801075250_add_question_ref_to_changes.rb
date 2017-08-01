class AddQuestionRefToChanges < ActiveRecord::Migration[5.1]
  def change
    add_reference :changes, :question, foreign_key: true
  end
end
