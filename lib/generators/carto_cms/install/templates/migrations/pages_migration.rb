class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :slug, null: false
      t.text :body
      t.string :name, null: false
      t.string :path
      t.string :format
      t.string :locale
      t.string :handler
      t.boolean :partial, default: false
      t.datetime :published_at

      t.timestamps
    end

    add_index :pages, :slug, unique: true
  end
end
