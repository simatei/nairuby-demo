class AddDetailsToAttendances < ActiveRecord::Migration[6.1]
  def change
    add_column :attendances, :email, :string
    add_column :attendances, :phone_number, :string
  end
end
