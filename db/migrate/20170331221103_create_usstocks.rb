class CreateUsstocks < ActiveRecord::Migration[5.0]
  def change
    create_table :usstocks do |t|
      t.string :juhe_gid
      t.string :name
      t.string :openpri
      t.string :formpri
      t.string :limit
      t.string :uppic
      t.string :priearn
      t.string :beta
      t.date   :chtime
      t.timestamps
    end
  end
end
