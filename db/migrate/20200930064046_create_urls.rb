class CreateUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :urls do |t|
      t.string :long, index: true, unique: true
      t.string :short, index: true, unique: true
      t.integer :match, default: 0

      t.timestamps
    end
  end
end
