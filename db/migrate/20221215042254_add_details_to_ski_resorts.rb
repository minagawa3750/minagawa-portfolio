class AddDetailsToSkiResorts < ActiveRecord::Migration[6.1]
  def change
    add_column :ski_resorts, :start_day, :date
    add_column :ski_resorts, :end_day, :date
    add_column :ski_resorts, :start_time, :time
    add_column :ski_resorts, :end_time, :time
  end
end
