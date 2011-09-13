class CreateMyfields < ActiveRecord::Migration
  def self.up
    create_table :myfields do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :myfields
  end
end
