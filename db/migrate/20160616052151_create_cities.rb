class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :from
      t.string :to

      t.timestamps null: false
    end
  end
end
