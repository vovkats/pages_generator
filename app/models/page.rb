class Page < ActiveRecord::Base

  has_many :subpages, class_name: 'Page', foreign_key: 'root_id'
end
