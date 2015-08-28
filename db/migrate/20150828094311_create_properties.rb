class CreateProperties < ActiveRecord::Migration
  def change
  	create_table :properties do |t|
  		t.string :title
  		t.string :description
  		t.integer :price
  		t.integer :bed
  		t.integer :bathroom
      t.integer :user_id
  		t.timestamps null: false
  	end
  end
end
