class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :slug,          null: false
      t.references :attachable, polymorphic: true
      t.string :type#,         null: false
      t.string :asset_path#,   null: false
      t.string :content_type#, null: false
      t.string :file_size#,    null: false
      t.integer :height
      t.integer :width

      t.timestamps
    end

    add_index :assets, :type
    add_index :assets, :attachable_id
    add_index :assets, :attachable_type
    add_index :assets, :slug, unique: true
  end
end
