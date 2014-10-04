class CreateNameMsts < ActiveRecord::Migration
  def change
    create_table :name_msts do |t|
      t.string :code_id
      t.string :code_id_name
      t.string :code
      t.text :name

      t.timestamps
    end
  end
end
