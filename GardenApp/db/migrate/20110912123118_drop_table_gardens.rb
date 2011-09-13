class DropTableGardens < ActiveRecord::Migration
  def self.up
    drop_table :gardens
  end

  def self.down
  end
end
