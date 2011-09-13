class GardenAddColumn < ActiveRecord::Migration
  def self.up
    add_column :gardens, :plantid, :integer, :default => 0
    add_column :gardens, :x, :integer, :default => 0
    add_column :gardens, :y, :integer, :default => 0
    add_column :gardens, :collect, :boolean, :default => false
    add_column :gardens, :growstep, :integer, :default => 1
    add_column :plants, :maxgrowstep, :integer, :default =>  5
  end

  def self.down
  end
end
