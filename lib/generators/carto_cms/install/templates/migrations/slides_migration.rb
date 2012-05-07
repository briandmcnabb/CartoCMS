class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.integer :position

      t.timestamps
    end

    add_index :slides, :position
  end
end