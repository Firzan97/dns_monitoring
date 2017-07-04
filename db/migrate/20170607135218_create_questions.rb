class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :dnsname
      t.string :recordtype
      t.string :server

      t.timestamps
    end
  end
end
