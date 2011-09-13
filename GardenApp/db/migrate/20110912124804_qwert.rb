class Qwert < ActiveRecord::Migration
  def self.up
    create_table :gardens do |t|
      t.integer :plant_id
      t.string  :plant_name
      t.integer :plant_step
      t.integer :plant_x
      t.integer :plant_y
      t.timestamps
    end

  end

  def self.down
    drop_table :field
  end
end