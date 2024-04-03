class CreateViews < ActiveRecord::Migration[7.1]
  def change
    create_table :views, id: :uuid do |t|
      t.string :shortcode, null: false, index: true
      t.timestamps
    end
  end
end
