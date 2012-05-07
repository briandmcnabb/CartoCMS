class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders do |t|
      t.integer :position
      t.string  :name
      t.text    :description

      t.timestamps
    end

    add_index :sliders, :position
  end
end