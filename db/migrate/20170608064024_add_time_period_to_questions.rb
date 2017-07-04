class AddTimePeriodToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :timeperiod, :integer
  end
end
