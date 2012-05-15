class CartoCreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text    :body
      t.string  :title
      t.string  :path
      t.string  :format
      t.string  :locale
      t.string  :handler
      t.boolean :partial, default: false
      t.string  :slug, null: false

      t.timestamps
    end

    add_index :pages, :slug, unique: true
  end
end
