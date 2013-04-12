class AddProductColumns < ActiveRecord::Migration
  def change
    add_column :products, :description, :text
    add_column :products, :in_cart, :boolean
    add_column :products, :image_url, :string
  end

end
