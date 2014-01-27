class Category < ActiveRecord::Base
	has_many :contents
	validates :text, presence: true
end
