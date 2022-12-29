class CreateSkiResorts < ActiveRecord::Migration[6.1]
  def change
    create_table :ski_resorts do |t|
      t.string :resort_name
      t.string :address
      t.text :hp_url
      t.string :phone_number
      t.string :business_hours
      t.string :business_period
      t.string :snow_quality
      t.text :resort_feature
      t.string :ski_lift
      t.string :resort_image

      t.timestamps
    end
  end
end
