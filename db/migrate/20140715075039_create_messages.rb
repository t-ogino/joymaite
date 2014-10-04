class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :msg_code
      t.text :message
      t.string :upd_uid

      t.timestamps
    end
  end
end
