class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|

    	t.string :name, null: false
    	t.string :price_per_month, null: false
      t.timestamps null: false
    end
  end
end
