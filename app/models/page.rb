class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :sub_pages, class_name: 'Page', foreign_key: 'root_id'

  scope :root_pages, -> { where(root_id: nil) }

  validates :name, presence: true
  validate :page_name

  def main?
    root_id.nil?
  end

  def parent
    Page.find_by(id: root_id)
  end

  private

  def page_name
    return true unless root_id

    if parent.sub_pages.where(name: name).present?
      errors[:name] << 'name must be uniq'
    end
  end
end
