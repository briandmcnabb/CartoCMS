class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.integer :position,    null: false
      t.string  :slug,        null: false
      t.string  :name,        null: false
      t.text    :description, null: false, default: ''
      t.references :slider
      t.references :slideable, polymorphic: true

      t.timestamps
    end

    add_index :slides, :position
    add_index :slides, :slug, unique: true
  end
end