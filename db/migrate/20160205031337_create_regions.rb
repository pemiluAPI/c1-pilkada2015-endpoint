class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string  :name
      t.string  :resource
    end
  end
end
