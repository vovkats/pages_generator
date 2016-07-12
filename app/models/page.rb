class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :sub_pages, class_name: 'Page', foreign_key: 'root_id'

  scope :root_pages, -> { where(root_id: nil) }

  def main?
    root_id.nil?
  end

  def parent
    Page.find_by(id: root_id)
  end

end
