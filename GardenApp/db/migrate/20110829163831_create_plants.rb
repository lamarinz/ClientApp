class CreatePlants < ActiveRecord::Migration
  def self.up
    create_table :plants do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :plants
  end
end
