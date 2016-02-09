class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.references :region
      t.string  :region_name
      t.references :city
      t.string  :city_name
      t.string  :name
      t.string  :pemilih
      t.string  :pengguna_hak_pilih
      t.string  :perolehan_suara
      t.string  :suara_sah
      t.string  :suara_tidak_sah
      t.string  :total_suara
      t.string  :link
      t.string  :resource
    end
    add_index :districts, :region_id
    add_index :districts, :city_id
    add_index :districts, :region_name
    add_index :districts, :city_name
    add_index :districts, :name
  end
end
