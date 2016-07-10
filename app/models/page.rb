class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :sub_pages, class_name: 'Page', foreign_key: 'root_id'
end
