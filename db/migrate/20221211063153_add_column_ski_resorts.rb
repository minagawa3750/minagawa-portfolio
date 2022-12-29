class AddColumnSkiResorts < ActiveRecord::Migration[6.1]
  def change
    add_column :ski_resorts, :courses, :integer
  end
end
