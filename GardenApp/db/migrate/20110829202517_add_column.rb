class AddColumn < ActiveRecord::Migration
  def self.up
    add_column :plants, :name, :string, :default => ''
  end

  def self.down
    remove_column :plants, :name
  end
end
