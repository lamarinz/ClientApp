class GrowstepsColumnAdd < ActiveRecord::Migration
  def self.up
    add_column :grow_steps, :plantid, :integer, :default => 0
    add_column :grow_steps, :imagefilelink, :string, :default => ''

  end

  def self.down
  end
end
