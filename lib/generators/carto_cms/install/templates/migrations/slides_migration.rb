class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.integer :position
      t.references :slider
      t.references :slideable, polymorphic: true
      t.string :name
      t.text :description
      t.string :slug, null: false

      t.timestamps
    end

    add_index :slides, :position
    add_index :slides, :slug, unique: true
  end
end