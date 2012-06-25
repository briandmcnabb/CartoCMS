class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.references :connectable, polymorphic: true
      t.string :provider
      t.string :uid
      t.string :token
      t.string :secret
      t.string :username
      t.string :url

      t.timestamps
    end
    add_index :connections, [:connectable_id, :connectable_type]
  end
end
