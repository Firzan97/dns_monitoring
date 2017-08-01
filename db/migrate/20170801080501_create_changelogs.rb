class CreateChangelogs < ActiveRecord::Migration[5.1]
  def change
    create_table :changelogs do |t|
      t.string :dnsname
      t.string :ipaddress
      t.string :typeanswer

      t.timestamps
    end
  end
end
