class CreateMemberMsts < ActiveRecord::Migration
  def change
    create_table :member_msts do |t|
      t.string :menber_no
      t.string :menber_name
      t.date :admission_date
      t.date :withdrawal_date
      t.date :birth_date
      t.date :enter_date
      t.date :marry_date
      t.string :memo
      t.string :del_flg

      t.timestamps
    end
  end
end
