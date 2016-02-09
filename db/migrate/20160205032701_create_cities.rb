class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.references :region
      t.string  :region_name
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
    add_index :cities, :region_id
    add_index :cities, :region_name
    add_index :cities, :name
  end
end
