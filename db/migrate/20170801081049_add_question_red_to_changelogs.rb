class AddQuestionRedToChangelogs < ActiveRecord::Migration[5.1]
  def change
    add_reference :changelogs, :question, foreign_key: true
  end
end
