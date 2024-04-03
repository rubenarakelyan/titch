class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links, id: false, primary_key: :shortcode do |t|
      t.string :shortcode, null: false, index: { unique: true }
      t.string :url, null: false
      t.string :title
      t.string :description
      t.string :og_image_url
      t.boolean :enabled, null: false, default: true
      t.string :created_by
      t.timestamps
    end
  end
end
