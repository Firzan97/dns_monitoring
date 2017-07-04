class CreateChoices < ActiveRecord::Migration[5.1]
  def change
    create_table :choices do |t|
      t.string :graphinterval
      t.string :question
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
