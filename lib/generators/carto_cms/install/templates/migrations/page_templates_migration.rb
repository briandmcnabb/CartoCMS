class CreatePageTemplates < ActiveRecord::Migration
  def change
    create_table :page_templates do |t|
      t.integer :position
      t.string :title
      t.text :body

      t.timestamps
    end

    add_index :page_templates, :position,     unique: true
  end
end
