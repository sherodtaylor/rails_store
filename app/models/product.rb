require 'open-uri'
class Product < ActiveRecord::Base
  attr_accessible :name, :price, :google, :in_cart, :image_url
  has_many :reviews
  validates :description, :length => { :in => 50..1000 } 
  validates :name, :uniqueness => true
  validates :name, :price, :presence => true
  def google(name)
    key = "AIzaSyDk3hh_cS7FVlcV1AgzQdIk89RZzGiQwzI"
    file = open("https://www.googleapis.com/shopping/search/v1/public/products?key=#{key}&country=US&q=#{URI.escape(name)}&alt=json")
    JSON.load(file.read)
  end
end
