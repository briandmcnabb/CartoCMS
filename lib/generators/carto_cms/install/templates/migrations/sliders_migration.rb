class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders do |t|
      t.integer :position,    null: false
      t.string  :slug,        null: false
      t.string  :name,        null: false
      t.text    :description, null: false, default: ''
      t.float   :aspect_ratio

      t.timestamps
    end

    add_index :sliders, :position
    add_index :sliders, :slug, unique: true
  end
end