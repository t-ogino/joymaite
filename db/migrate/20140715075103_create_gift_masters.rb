class CreateGiftMasters < ActiveRecord::Migration
  def change
    create_table :gift_masters do |t|
      t.string :gift_div
      t.string :condition
      t.integer :condition_year
      t.string :amount
      t.string :year_flg

      t.timestamps
    end
  end
end
