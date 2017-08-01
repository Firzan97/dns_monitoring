class AddQuestiononRefToLogs < ActiveRecord::Migration[5.1]
  def change
    add_reference :logs, :question, foreign_key: true
  end
end
