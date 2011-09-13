class CreateGardens < ActiveRecord::Migration
  def self.up
    create_table :gardens do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :gardens
  end
end
