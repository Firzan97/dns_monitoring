class AddQuestionRefToPerformances < ActiveRecord::Migration[5.1]
  def change
    add_reference :performances, :question, foreign_key: true
  end
end
