# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110912130404) do

  create_table "field", :force => true do |t|
    t.integer  "plant_id"
    t.string   "plant_name"
    t.integer  "plant_step"
    t.integer  "plant_x"
    t.integer  "plant_y"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gardens", :force => true do |t|
    t.integer  "plant_id"
    t.string   "plant_name"
    t.integer  "plant_step"
    t.integer  "plant_x"
    t.integer  "plant_y"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "myfields", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plant_id",   :default => 0
    t.string   "plant_name", :default => ""
    t.integer  "plant_step", :default => 0
    t.integer  "plant_x",    :default => 0
    t.integer  "plant_y",    :default => 0
  end

  create_table "plants", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",        :default => ""
    t.integer  "maxgrowstep", :default => 5
  end

end
