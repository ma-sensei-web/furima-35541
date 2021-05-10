class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :status, :charge, :area, :day

  belongs_to :user
  has_one_attached :image 
end
