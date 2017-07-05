class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :dnsname
      t.string :ttl
      t.string :recordtype
      t.string :ipaddress

      t.timestamps
    end
  end
end
