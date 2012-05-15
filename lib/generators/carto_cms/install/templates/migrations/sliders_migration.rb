class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders do |t|
      t.integer :position
      t.string  :name
      t.text    :description
      t.string  :slug, null: false

      t.timestamps
    end

    add_index :sliders, :position
    add_index :sliders, :slug, unique: true
  end
end