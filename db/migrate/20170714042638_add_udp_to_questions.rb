class AddUdpToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :udp, :string
  end
end
