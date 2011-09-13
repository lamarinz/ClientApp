class GardenController < ApplicationController
  require 'builder'
  def setDB
    v = ['Potato', 'Sunflower', 'Clover']
    v.each do |p|
      @plants = Plants.new
      @plants.name = p
      @plants.save
    end
    render :text => 'All good'
  end

  def get_plants_list
    @plants = Plants.all
    vdoc = Builder::XmlMarkup.new( :target => out_string = "", :indent => 2)
    vdoc.PlantsList {
        @plants.each do |pl|
          vdoc.Plant("ID" => pl[:id], "name" => pl[:name])
        end
    }
    render :xml => out_string
  end

  def get_garden_state
   @field = Myfield.all
    vdoc = Builder::XmlMarkup.new( :target => out_string = "", :indent => 2)
    vdoc.Field {
        @field.each do |pl|
          vdoc.Plant("ID" => pl[:plant_id], "name" => pl[:plant_name], "step" => pl[:plant_step], "x" => pl[:plant_x], "y" => pl[:plant_y])
        end
    }
    render :xml => out_string
  end

  def clear
    @field = Myfield.all
    @field.each do |f|
      f.delete
    end
  end

  def plant_add
    @field = Myfield.new
    @field.plant_id = params[:id]
    @field.plant_name = params[:name]
    @field.plant_step = params[:step]
    @field.plant_x = params[:x]
    @field.plant_y = params[:y]
    @field.save
    render :xml => "<good></good>"
  end

  def plant_collect
    plant_id = params[:id]
    @collect_field = Myfield.find_by_plant_id(plant_id)
    @collect_field.delete
    render :xml => "<good></good>"
  end

  def plant_growup
    plant_id = params[:id]
    next_step = params[:step]
    y = params[:y]
    @plant = Myfield.find_by_plant_id(plant_id)
    @plant.plant_step = next_step
    @plant.plant_y = y
    @plant.save
    render :xml => "<good></good>"
  end

end

