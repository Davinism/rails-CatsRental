class DefaultValue < ActiveRecord::Migration
  def change
    change_column :cat_rental_requests, :status, :string, null: false, default: "PENDING"
  end
end
