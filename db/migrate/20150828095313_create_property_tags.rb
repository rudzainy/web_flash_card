class CreatePropertyTags < ActiveRecord::Migration
  def change
  	create_table :property_tags do |t|
  		t.integer :tag_id
  		t.integer :property_id
  	end
  end
end
