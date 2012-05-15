class CreatePageTemplates < ActiveRecord::Migration
  def change
    create_table :page_templates do |t|
      t.integer :position
      t.string :title
      t.text :description
      t.text :body
      t.string :slug, null: false

      t.timestamps
    end

    add_index :page_templates, :position
    add_index :page_templates, :slug, unique: true
  end
end
