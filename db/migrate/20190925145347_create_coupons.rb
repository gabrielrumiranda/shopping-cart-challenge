class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :type
      t.belongs_to :cart
      t.timestamps
    end
  end
end
