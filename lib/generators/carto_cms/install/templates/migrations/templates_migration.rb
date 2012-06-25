class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.integer :position, null: false
      t.string :slug,      null: false
      t.string :name,      null: false
      t.text :description, null: false, default: ''
      t.text :body,        null: false, default: ''

      t.timestamps
    end

    add_index :templates, :position
    add_index :templates, :slug, unique: true
  end
end
