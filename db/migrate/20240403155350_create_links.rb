class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links, id: :uuid do |t|
      t.string :shortcode, null: false, index: true
      t.string :url, null: false
      t.string :title
      t.string :description
      t.string :og_image_url
      t.boolean :enabled, null: false, default: true
      t.timestamps
    end
  end
end
