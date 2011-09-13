class CreateGrowSteps < ActiveRecord::Migration
  def self.up
    create_table :grow_steps do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :grow_steps
  end
end
