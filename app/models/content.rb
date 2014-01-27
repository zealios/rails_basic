class Content < ActiveRecord::Base
  belongs_to :category
  validates :title, presence: true
  validates :subtitle, presence: true
  validates :text, presence: true
end
