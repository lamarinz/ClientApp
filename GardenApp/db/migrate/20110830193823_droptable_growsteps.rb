class DroptableGrowsteps < ActiveRecord::Migration
  def self.up
    drop_table :grow_steps
  end

  def self.down
  end
end
