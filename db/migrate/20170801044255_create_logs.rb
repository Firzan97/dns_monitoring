class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.string :dnsname
      t.string :ipaddress
      t.string :typeanswer

      t.timestamps
    end
  end
end
