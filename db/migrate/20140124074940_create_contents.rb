class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.string :subtitle
      t.text :text
      t.references :category, index: true

      t.timestamps
    end
  end
end
