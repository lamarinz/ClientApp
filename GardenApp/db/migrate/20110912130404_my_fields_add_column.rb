class MyFieldsAddColumn < ActiveRecord::Migration
  def self.up
    add_column :myfields, :plant_id, :integer, :default => 0
    add_column :myfields, :plant_name, :string, :default => ""
    add_column :myfields, :plant_step, :integer, :default => 0
    add_column :myfields, :plant_x, :integer, :default => 0
    add_column :myfields, :plant_y, :integer, :default => 0
  end

  def self.down

  end
end
