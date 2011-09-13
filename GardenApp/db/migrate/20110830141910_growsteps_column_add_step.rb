class GrowstepsColumnAddStep < ActiveRecord::Migration
  def self.up
    add_column :grow_steps, :stepnumber, :integer, :default => 0  end

  def self.down
  end
end
